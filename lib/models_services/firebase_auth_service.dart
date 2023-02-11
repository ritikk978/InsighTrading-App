import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:insigh/models_services/firebase_image_service.dart';

import '../models/auth_user.dart';
import '../utils/z_utils.dart';
import '../utils/z_validators.dart';

class FirebaseAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseMessaging _firestoreMessaging = FirebaseMessaging.instance;

/* ---------------------------- NOTE GET AUTHUSER --------------------------- */
  static Future<AuthUser?> getAuthUser() async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return null;

    var doc = await _firestore.collection('users').doc(fbUser.uid).get();
    return AuthUser.fromJson({...?doc.data(), 'id': doc.id});
  }

  static Future<User?> getFirebaseUser() async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) await signInAnonymously();
    fbUser = FirebaseAuth.instance.currentUser;
    return fbUser;
  }

  /* ---------------------------- NOTE Stream User ---------------------------- */
  static Stream<AuthUser>? streamAuthUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    var ref = FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots();
    return ref.map((snap) => AuthUser.fromJson({...?snap.data(), 'id': snap.id}));
  }

/* --------------------------- NOTE GOOGLE SIGNIN --------------------------- */
  static Future<User?> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    var signInResult = await _auth.signInWithCredential(credential);

    final User? user = signInResult.user;
    if (user == null) return null;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    String? token = await _firestoreMessaging.getToken();

    var query = await _firestore.collection('users').doc(user.uid).get();

    if (!query.exists) {
      await _firestore.collection('users').doc(user.uid).set({
        'appBuildNumber': appBuildNumber,
        'isAnonymous': false,
        'appVersion': appVersion,
        'devTokens': FieldValue.arrayUnion([token]),
        'email': user.email,
        'firstName': '',
        'lastName': '',
        'timestampLastLogin': DateTime.now(),
        'timestampCreated': DateTime.now(),
        'timestampUpdated': DateTime.now(),
        'isActive': true,
        'isNotificationsEnabled': true,
        'stripeTestCustomerId': '',
        'stripeLiveCustomerId': '',
      });
    }

    if (query.exists) {
      await _firestore.collection('users').doc(user.uid).update({
        'appBuildNumber': appBuildNumber,
        'isAnonymous': false,
        'appVersion': appVersion,
        'devTokens': FieldValue.arrayUnion([token]),
        'email': user.email,
        'timestampLastLogin': DateTime.now(),
      });
    }

    query = await _firestore.collection('users').doc(user.uid).get();
    if (query.exists) {
      AuthUser.fromJson({...?query.data(), 'id': query.id});
    }

    return user;
  }

  /* ------------------------ NOTE SIGIN IN WITH APPLE ------------------------ */
  static Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(idToken: appleCredential.identityToken);

      final signInResult = await _auth.signInWithCredential(oauthCredential);

      final User? user = signInResult.user;
      if (user == null) return null;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;
      num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
      String? token = await _firestoreMessaging.getToken();

      var query = await _firestore.collection('users').doc(user.uid).get();

      if (!query.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'appBuildNumber': appBuildNumber,
          'isAnonymous': false,
          'appVersion': appVersion,
          'devTokens': FieldValue.arrayUnion([token]),
          'email': user.email,
          'firstName': '',
          'lastName': '',
          'timestampLastLogin': DateTime.now(),
          'timestampCreated': DateTime.now(),
          'timestampUpdated': DateTime.now(),
          'isActive': true,
          'isNotificationsEnabled': true,
          'stripeTestCustomerId': '',
          'stripeLiveCustomerId': '',
        });
      }
      if (query.exists) {
        await _firestore.collection('users').doc(user.uid).update({
          'appBuildNumber': appBuildNumber,
          'isAnonymous': false,
          'appVersion': appVersion,
          'devTokens': FieldValue.arrayUnion([token]),
          'email': user.email,
          'timestampLastLogin': DateTime.now(),
        });
      }

      query = await _firestore.collection('users').doc(user.uid).get();
      if (query.exists) {
        AuthUser.fromJson({...?query.data(), 'id': query.id});
      }

      return user;
    } catch (e) {
      return null;
    }
  }

/* ------------------------- NOTE  signInAnonymously ------------------------ */
  static Future<User?> signInAnonymously() async {
    UserCredential credential = await _auth.signInAnonymously();
    if (credential.user == null) return null;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    String? token = await _firestoreMessaging.getToken();

    await _firestore.collection('users').doc(credential.user!.uid).set({
      'appBuildNumber': appBuildNumber,
      'isAnonymous': true,
      'appVersion': appVersion,
      'devTokens': FieldValue.arrayUnion([token]),
      'email': null,
      'firstName': '',
      'lastName': '',
      'timestampLastLogin': DateTime.now(),
      'timestampCreated': DateTime.now(),
      'timestampUpdated': DateTime.now(),
      'isActive': true,
      'isAdmin': false,
      'isNotificationsEnabled': true,
      'stripeTestCustomerId': '',
      'stripeLiveCustomerId': '',
    });

    var query = await _firestore.collection('users').doc(credential.user!.uid).get();
    if (query.exists) {
      AuthUser.fromJson({...?query.data(), 'id': query.id});
    }

    return credential.user!;
  }

  static Future<User?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;
      num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
      String? token = await _firestoreMessaging.getToken();

      await _firestore.collection('users').doc(user!.uid).update({
        'appBuildNumber': appBuildNumber,
        'isAnonymous': false,
        'appVersion': appVersion,
        'devTokens': FieldValue.arrayUnion([token]),
        'timestampUpdated': DateTime.now(),
      });

      var query = await _firestore.collection('users').doc(user.uid).get();
      if (query.exists) {
        AuthUser.fromJson({...?query.data(), 'id': query.id});
      }

      return user;
    } catch (e) {
      ZUtils.showToastError(message: ZValidators.getMessageFromErrorCode(e));
      return null;
    }
  }

  static Future<User?> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;
      num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
      String? token = await _firestoreMessaging.getToken();

      await _firestore.collection('users').doc(user!.uid).set({
        'appBuildNumber': appBuildNumber,
        'isAnonymous': false,
        'appVersion': appVersion,
        'devTokens': FieldValue.arrayUnion([token]),
        'email': email,
        'firstName': '',
        'lastName': '',
        'timestampLastLogin': DateTime.now(),
        'timestampCreated': DateTime.now(),
        'timestampUpdated': DateTime.now(),
        'isActive': true,
        'isAdmin': false,
        'isNotificationsEnabled': true,
        'stripeTestCustomerId': '',
        'stripeLiveCustomerId': '',
      });

      var query = await _firestore.collection('users').doc(user.uid).get();
      if (query.exists) {
        AuthUser.fromJson({...?query.data(), 'id': query.id});
      }

      return user;
    } catch (e) {
      ZUtils.showToastError(message: ZValidators.getMessageFromErrorCode(e));
      return null;
    }
  }

/* --------------------- NOTE Update Appversion Login & dev token --------------------- */
  static Future<void> updateAppVersionLastLogin() async {
    String? currentDevToken = await _firestoreMessaging.getToken();
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

    await _firestore.collection('users').doc(fbUser.uid).set({
      'appBuildNumber': appBuildNumber,
      'appVersion': appVersion,
      'devTokens': FieldValue.arrayUnion([currentDevToken]),
      'timestampLastLogin': DateTime.now(),
    }, SetOptions(merge: true));
  }

  /* --------------------- NOTE Notifications --------------------- */
  static Future<void> toggleNotifications({required bool value}) async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return;
    _firestore.collection('users').doc(fbUser.uid).update({'isNotificationsEnabled': value});
  }

  static Future<void> uploadProfilePicture({required File file}) async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return;
    String url = await FirebaseImageService.uploadImgFireStorageFile(imageFile: file);

    _firestore.collection('users').doc(fbUser.uid).update({'profileimage': url});
  }

  static Future<String?> updateUserName({required String name}) async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return null;

    try {
      await _firestore.collection('users').doc(fbUser.uid).update({'name': name});
      return name;
    } catch (e) {
      return null;
    }
  }

/* ------------------------------ NOTE SIGNOUT ------------------------------ */
  static signOut() async {
    User? fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) return;
    _auth.signOut();
  }
}
