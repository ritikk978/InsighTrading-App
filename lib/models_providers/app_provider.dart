import 'dart:async';

import 'package:flutter/material.dart' hide Notification;
import 'package:insigh/models/app_control_disclaimer.dart';
import 'package:insigh/models_services/commom_repository.dart';
import 'package:insigh/utils/string_constants.dart';

import '../models/advance_decline.dart';
import '../models/announcement.dart';
import '../models/app_control.dart';
import '../models/app_control_links.dart';
import '../models/fincode_data_model.dart';
import '../models/notification.dart';
import '../models/post.dart';
import '../models/signal.dart';
import '../models/video_lesson.dart';
import '../models/yahoo_finance_stock_data.dart';
import '../models_services/firestore_service.dart';
import '../utils/common_methods.dart';
import 'auth_provider.dart';

class AppProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /* -------------------------------- NOTE Init ------------------------------- */
  String? authUserId;
  AuthProvider? _authProvider;
  AuthProvider? get authProvider => _authProvider;

  set authProvider(AuthProvider? authProvider) {
    _authProvider = authProvider;
    bool rerun = authUserId == null || authUserId == '' || authUserId != _authProvider?.authUser?.id;

    if (_authProvider?.authUser != null && rerun) {
      streamAppControl();
      streamAppControlLinks();
      // streamAppControlDisclaimer();
      streamSignals();
      streamAnnouncements();
      streamNotifications();
      streamVideoLessons();
      streamPosts();
      streamAdvanceDecline();

      authUserId = _authProvider?.authUser?.id ?? '';
    }

    if (_authProvider?.authUser == null) {
      cancleStreamAppControl();
      cancleStreamAppControlLinks();
      cancleStreamSignals();
      cancleStreamAnnouncements();
      cancleStreamNotifications();
      cancleStreamVideoLessons();
      cancelStreamPosts();
      streamLiveGlobalIndicesPrice();
      authUserId = _authProvider?.authUser?.id ?? '';
    }
  }

  /* -------------------------------- NOTE Cancle Streams ------------------------------- */
  void cancleAllStreams() {
    cancleStreamAppControl();
    cancleStreamAppControlLinks();
    cancleStreamVideoLessons();
    cancleStreamSignals();
    cancleStreamAnnouncements();
    cancleStreamNotifications();
    cancelStreamPosts();
    cancelStreamAdvanceDecline();
    cancelStreamLiveGlobalIndicesPrice();
    notifyListeners();
    authUserId = null;
  }

  /* ---------------------------- NOTE APP CONTROLL --------------------------- */
  AppControl _appControl = AppControl();
  AppControl get appControl => _appControl;
  StreamSubscription<AppControl>? _streamSubscriptionAppControl;

  void streamAppControl() {
    var res = FirestoreService.streamAppControl();
    _streamSubscriptionAppControl = res.listen((event) async {
      _appControl = event;
    });
  }

  void cancleStreamAppControl() {
    _streamSubscriptionAppControl?.cancel();
  }

  /* -------------------------- NOTE APPCONTROL LINKS ------------------------- */
  AppControlLinks _appControlLinks = AppControlLinks();
  AppControlLinks get appControlLinks => _appControlLinks;
  StreamSubscription<AppControlLinks>? _streamSubscriptionAppControlLinks;

  void streamAppControlLinks() {
    var res = FirestoreService.streamAppControlLinks();
    _streamSubscriptionAppControlLinks = res.listen((event) async {
      _appControlLinks = event;
      notifyListeners();
    });
  }

  void cancleStreamAppControlLinks() {
    _streamSubscriptionAppControlLinks?.cancel();
  }

  /* -------------------------- NOTE APPCONTROL Disclaimer ------------------------- */
  AppControlDisclaimer _appControlDisclaimer = AppControlDisclaimer();
  AppControlDisclaimer get appControlDisclaimer => _appControlDisclaimer;
  StreamSubscription<AppControlDisclaimer>? _streamSubscriptionAppControlDisclaimer;

  void streamAppControlDisclaimer() {
    var res = FirestoreService.streamAppControlDisclaimer();
    _streamSubscriptionAppControlDisclaimer = res.listen((event) async {
      _appControlDisclaimer = event;
      notifyListeners();
    });
  }

  void cancleStreamAppControlDisclaimer() {
    _streamSubscriptionAppControlDisclaimer?.cancel();
  }

  /* ----------------------------- NOTE LIVE PRICE ---------------------------- */
  List<Signal> _signals = [];
  List<Signal> get signals => _signals;
  StreamSubscription<AppControl>? _streamSubscriptionSignals;

  void streamSignals() {
    var res = FirestoreService.streamSignals();
    res.listen((event) async {
      await updateLivePriceForSignals(event);
    });
  }

  Future<void> updateLivePriceForSignals(List<Signal> event) async {
    var finCode = '';
    event.forEach((element) {
      if(element.finCode.isNotEmpty){
        finCode += element.finCode + ',';
      }
    });
    var data = await CommonRepository.getLtpPrice(finCode.substring(0, finCode.length - 1));
    Map<String, LivePriceData> ltpData = {};
    data.data!.list!.forEach((element) {
      if(element.ltpPrice != 0){
        ltpData[element.symbol.toString()] = element;
      }
    });
    event.forEach((element) {
      element.ltpPrice = ltpData[element.finCode]!.ltpPrice!;
      element.changePercent = ltpData[element.finCode]!.regularMarketChangePercent!;
    });
    _signals = event;
    notifyListeners();
  }

  void cancleStreamSignals() {
    _streamSubscriptionAppControl?.cancel();
  }

  /* -------------------------------- NOTE GlobalIndicesPrice ------------------------------- */
  List<LivePriceData> _livePriceData = [];
  List<LivePriceData> get livePriceData => _livePriceData;
  StreamController<List<LivePriceData>> streamLiveGlobalIndicesPriceController = StreamController.broadcast();
  StreamSubscription<List<LivePriceData>>? _streamLiveGlobalIndicesPrice;

  Future<void> streamLiveGlobalIndicesPrice() async {
    var res = await CommonRepository.getGlobalIndicesDataFromYahooFinance(StringConstants.globalIndeces);
    streamLiveGlobalIndicesPriceController.add(res.data!.list!);
    _streamLiveGlobalIndicesPrice = streamLiveGlobalIndicesPriceController.stream.listen((event) {
      _livePriceData = event;
      notifyListeners();
    });
  }

  void cancelStreamLiveGlobalIndicesPrice() {
    // _streamLiveGlobalIndicesPrice?.cancel();
  }

  /* -------------------------------- NOTE Post ------------------------------- */
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  StreamSubscription<List<Post>>? _streamSubscriptionPosts;

  void streamPosts() {
    var res = FirestoreService.streamPost();
    _streamSubscriptionPosts = res.listen((event) {
      _posts = event;
      notifyListeners();
    });
  }

  void cancelStreamPosts() {
    _streamSubscriptionPosts?.cancel();
  }

  /* -------------------------------- NOTE Post ------------------------------- */
  List<AdvanceDeclineModelData> _advanceDeclineList = [];
  List<AdvanceDeclineModelData> get advanceDeclineList => _advanceDeclineList;
  StreamController<List<AdvanceDeclineModelData>> streamController = StreamController();
  StreamSubscription<List<AdvanceDeclineModelData>>? _streamSubscriptionAdvanceDecline;

  Future<void> streamAdvanceDecline() async {
    var res = await CommonRepository.getAdvanceDeclineList();
    streamController.add(res.data!.list);
    _streamSubscriptionAdvanceDecline = streamController.stream.listen((event) {
      _advanceDeclineList = event;
      notifyListeners();
    });
  }

  void cancelStreamAdvanceDecline() {
    _streamSubscriptionAdvanceDecline?.cancel();
  }

  /* -------------------------------- NOTE Video ------------------------------- */
  List<VideoLesson> _videoLessons = [];
  List<VideoLesson> get videoLessons => _videoLessons;
  StreamSubscription<List<VideoLesson>>? _streamSubscriptionVideoLessons;

  void streamVideoLessons() {
    var res = FirestoreService.streamVideoLessons();
    _streamSubscriptionVideoLessons = res.listen((event) {
      _videoLessons = event;
      notifyListeners();
    });
  }

  void cancleStreamVideoLessons() {
    _streamSubscriptionVideoLessons?.cancel();
  }

  /* ---------------------------- NOTE ANNOUCEMENTS --------------------------- */
  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;
  StreamSubscription<Announcement>? _streamSubscriptionAnnouncements;

  void streamAnnouncements() {
    var res = FirestoreService.streamAnnouncements();
    res.listen((event) {
      _announcements = event;
      notifyListeners();
    });
  }

  void cancleStreamAnnouncements() {
    _streamSubscriptionAnnouncements?.cancel();
  }

  /* ---------------------------- NOTE ANNOUCEMENTS --------------------------- */
  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;
  StreamSubscription<Notification>? _streamSubscriptionNotifications;

  void streamNotifications() {
    var res = FirestoreService.streamNotification();
    res.listen((event) {
      _notifications = event;
      notifyListeners();
    });
  }

  void cancleStreamNotifications() {
    _streamSubscriptionNotifications?.cancel();
  }
}
