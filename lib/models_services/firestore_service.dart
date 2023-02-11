import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insigh/models/app_control_links.dart';

import '../models/announcement.dart';
import '../models/app_control.dart';
import '../models/app_control_disclaimer.dart';
import '../models/notification.dart';
import '../models/post.dart';
import '../models/signal.dart';
import '../models/support.dart';
import '../models/video_lesson.dart';

class FirestoreService {
  static Stream<AppControl> streamAppControl() {
    var ref = FirebaseFirestore.instance.collection('appControl').doc('appControl').snapshots();
    return ref.map((doc) => AppControl.fromJson({...?doc.data(), "id": doc.id}));
  }

  static Stream<AppControlLinks> streamAppControlLinks() {
    var ref = FirebaseFirestore.instance.collection('appControlsPublic').doc('links').snapshots();
    return ref.map((doc) => AppControlLinks.fromJson({...?doc.data(), "id": doc.id}));
  }

  static Stream<AppControlDisclaimer> streamAppControlDisclaimer() {
    var ref = FirebaseFirestore.instance.collection('appControlsPublic').doc('disclaimer').snapshots();
    return ref.map((doc) => AppControlDisclaimer.fromJson({...?doc.data(), "id": doc.id}));
  }

  static Stream<List<Signal>> streamSignals() {
    var ref = FirebaseFirestore.instance.collection('signals').where('isActive', isEqualTo: true).snapshots();
    var docs = ref.map((doc) => doc.docs.map((doc) => Signal.fromJson({...doc.data(), "id": doc.id})).toList());
    return docs.map((list) => list..sort((a, b) => b.entryDatetime!.compareTo(a.entryDatetime!)));
  }

  static Future<List<Signal>> getSignalsClosed() async {
    var ref = FirebaseFirestore.instance.collection('signals').where('isActive', isEqualTo: false).get();
    var docs = (await ref).docs.map((doc) => Signal.fromJson({...doc.data(), "id": doc.id})).toList();
    return docs..sort((a, b) => b.entryDatetime!.compareTo(a.entryDatetime!));
  }

  static Stream<List<Post>> streamPost() {
    var ref =
        FirebaseFirestore.instance.collection('posts').where('status', isEqualTo: 'Published').orderBy('postDate', descending: true).snapshots();
    return ref.map((doc) => doc.docs.map((doc) => Post.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<VideoLesson>> streamVideoLessons() {
    var ref = FirebaseFirestore.instance.collection('videoLessons').where('isActive', isEqualTo: true).snapshots();
    return ref.map((doc) => doc.docs.map((doc) => VideoLesson.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Announcement>> streamAnnouncements() {
    var ref = FirebaseFirestore.instance.collection('announcements').orderBy('timestampCreated', descending: true).snapshots();
    return ref.map((doc) => doc.docs.map((doc) => Announcement.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Stream<List<Notification>> streamNotification() {
    var ref = FirebaseFirestore.instance.collection('notifications').orderBy('timestampCreated', descending: true).snapshots();
    return ref.map((doc) => doc.docs.map((doc) => Notification.fromJson({...doc.data(), "id": doc.id})).toList());
  }

  static Future<bool> addSupport(Support support) async {
    var ref = FirebaseFirestore.instance.collection('supports').doc();
    try {
      await ref.set(support.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
