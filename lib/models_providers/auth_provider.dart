import 'dart:async';

import 'package:insigh/utils/z_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../_app_navbar_page.dart';
import '../models/auth_user.dart';
import '../models_services/firebase_auth_service.dart';
import '../models_services/revenuecat_service.dart';

class AuthProvider with ChangeNotifier {
  AuthUser? _authUser;
  AuthUser? get authUser => _authUser;
  StreamSubscription<AuthUser>? _streamSubscriptionAuthUser;

  User? _user;

  Future init() async {
    _user = await FirebaseAuthService.getFirebaseUser();
    if (_user == null) return;

    Get.offAll(() => AppNavbarPage());
    FirebaseAuthService.updateAppVersionLastLogin();
    // _setRevenueCatId();

    Stream<AuthUser>? streamAuthUser = FirebaseAuthService.streamAuthUser();
    _streamSubscriptionAuthUser = streamAuthUser?.listen((res) async {
      _authUser = res;
      notifyListeners();
    });

    notifyListeners();
    return _authUser;
  }

  Future initReload() async {
    _user = await FirebaseAuthService.getFirebaseUser();
    if (_user == null) return;

    _streamSubscriptionAuthUser?.cancel();
    Stream<AuthUser>? streamAuthUser = FirebaseAuthService.streamAuthUser();
    _streamSubscriptionAuthUser = streamAuthUser?.listen((res) async {
      _authUser = res;
      notifyListeners();
    });

    // _setRevenueCatId();
    FirebaseAuthService.updateAppVersionLastLogin();

    return _authUser;
  }

  void cancleAllStreams() {
    _streamSubscriptionAuthUser?.cancel();
    _authUser = null;
    notifyListeners();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    _streamSubscriptionAuthUser?.cancel();
    _authUser = null;
    notifyListeners();
  }

/* ------------------------- NOTE SIGN IN WITH EMAIL ------------------------ */
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async {
    AuthUser? authUser;
    try {
      var _user = await FirebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
      if (_user != null) authUser = await init();
      return authUser;
    } catch (e) {
      return null;
    }
  }

/* ------------------------- NOTE SIGN UP WITH EMAIL ------------------------ */
  Future<AuthUser?> signUpWithEmailAndPassword(String email, String password) async {
    AuthUser? authUser;
    try {
      var _user = await FirebaseAuthService.signUpWithEmailAndPassword(email: email, password: password);
      if (_user != null) authUser = await init();
      return authUser;
    } catch (e) {
      return null;
    }
  }

/* ----------------------------- NOTE REVENUECAT ---------------------------- */

  // EntitlementInfo? _entitlementInfo;
  // EntitlementInfo? get entitlementInfo => _entitlementInfo;
  // bool _isloadingRestorePurchases = false;
  // bool get isloadingRestorePurchases => _isloadingRestorePurchases;
  //
  // List<Package> _packages = [];
  // List<Package> get packages => _packages;
  //
  // bool _isLoadingEntitlementInfo = false;
  // bool get isLoadingEntitlementInfo => _isLoadingEntitlementInfo;
  //
  // void _setRevenueCatId() async {
  //   try {
  //     await Purchases.logIn(_authUser!.id!);
  //     checkPurchasesStatus();
  //     Purchases.addCustomerInfoUpdateListener((info) async {
  //       checkPurchasesStatus();
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // void restorePurchases() async {
  //   try {
  //     _isloadingRestorePurchases = true;
  //     notifyListeners();
  //
  //     await Purchases.restorePurchases();
  //     checkPurchasesStatus();
  //     await Future.delayed(Duration(seconds: 2));
  //     ZUtils.showToastSuccess(message: 'Restore Purchases Success');
  //
  //     _isloadingRestorePurchases = false;
  //     notifyListeners();
  //     return;
  //   } catch (e) {
  //     checkPurchasesStatus();
  //     await ZUtils.showToastError(message: 'Restore Purchases Failed');
  //
  //     _isloadingRestorePurchases = false;
  //     notifyListeners();
  //   }
  // }
  //
  // void checkPurchasesStatus({bool getPackages = false}) async {
  //   _isLoadingEntitlementInfo = true;
  //   notifyListeners();
  //
  //   if (getPackages) {
  //     _packages = await RevenueCatSevice.getPackages();
  //     print('CALLLED checkPurchasesStatus _packages ${_packages}');
  //   }
  //
  //   CustomerInfo info = await Purchases.getCustomerInfo();
  //
  //   List<EntitlementInfo> _entitlements = info.entitlements.active.values.toList();
  //   _entitlements.sort((a, b) => b.latestPurchaseDate.compareTo(a.latestPurchaseDate));
  //   if (_entitlements.isEmpty) _entitlementInfo = null;
  //
  //   if (_entitlements.length >= 1) {
  //     _entitlementInfo = _entitlements[0];
  //     RevenueCatSevice.updateUserSub(_entitlementInfo!);
  //   }
  //
  //   //Just check if the user has a subscription that expired
  //   List<EntitlementInfo> _entitlementsAll = info.entitlements.all.values.toList();
  //   _entitlementsAll.sort((a, b) => b.latestPurchaseDate.compareTo(a.latestPurchaseDate));
  //   if (_entitlements.isEmpty && _entitlementsAll.isNotEmpty) {
  //     RevenueCatSevice.updateUserSub(_entitlementsAll[0]);
  //   }
  //
  //   // info.entitlements.all.forEach((key, value) {
  //   //   print('###############################################');
  //   //   print('isActive ${value.isActive}');
  //   //   print('willRenew ${value.willRenew}');
  //   //   print('periodType ${value.periodType}');
  //   //   print('productIdentifier ${value.productIdentifier}');
  //   //   print('value.isSandbox ${value.isSandbox}');
  //   //   print('originalPurchaseDate ${parseToDayTimeUTCString(value.originalPurchaseDate)}');
  //   //   print('latestPurchaseDate ${parseToDayTimeUTCString(value.latestPurchaseDate)}');
  //   //   print('expirationDate ${parseToDayTimeUTCString(value.expirationDate)}');
  //   //   print('unsubscribeDetectedAt ${parseToDayTimeUTCString(value.unsubscribeDetectedAt)}');
  //   //   print('billingIssueDetectedAt ${parseToDayTimeUTCString(value.billingIssueDetectedAt)}');
  //   //   print('###############################################');
  //   // });
  //
  //   _isLoadingEntitlementInfo = false;
  //   notifyListeners();
  // }

  checkIfStringContainsString(String string, String substring) {
    return string.toLowerCase().contains(substring.toLowerCase());
  }
}
