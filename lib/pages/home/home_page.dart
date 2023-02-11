import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:insigh/models/advance_decline.dart';
import 'package:insigh/pages/user/notification_screen.dart';
import 'package:insigh/utils/app_bar.dart';
import 'package:insigh/utils/string_constants.dart';
import 'package:provider/provider.dart';

import '../../components/z_card.dart';
import '../../components/z_image_display.dart';
import '../../constants/app_colors.dart';

import '../../constants/images.dart';
import '../../models/announcement.dart';
import '../../models/notification.dart';
import '../../models_providers/app_provider.dart';
import '../../models_services/commom_repository.dart';
import '../../utils/common_methods.dart';
import '../../utils/z_format.dart';
import '../user/signals_closed_page.dart';
import '../user/web_view_screen.dart';
import 'advance_decline_view.dart';
import 'global_indices_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      Provider.of<AppProvider>(context, listen: false).streamLiveGlobalIndicesPrice();
    });

    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final notifications = appProvider.notifications;
    final advanceDecline = appProvider.advanceDeclineList;
    final globalIndicesData = appProvider.livePriceData;
    return Scaffold(
      appBar: InsighTradingAppBar(actions: []),
      floatingActionButton: GestureDetector(
        onTap: (() => Get.to(
                () => NotificationDisplay(notifications: notifications),
            fullscreenDialog: true,
            duration: Duration(milliseconds: 500))),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: appColorBlue,
            border: Border.all(
              color: appColorBlue
            ),
            borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset('assets/svg/notification.svg',
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            GlobalIndicesWidget(globalIndicesData, false),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StockHeatMapCard(context),
                AdvanceDeclineCard(advanceDecline),
                MarketMoodInsightCard(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget MarketMoodInsightCard(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 10, top: 8, right: 10),
    child: InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => WebViewScreen(
                url: 'https://www.tickertape.in/market-mood-index',
                title: 'Market Mood Insight')));
      },
      child: Container(
        height: 100,
        width: 100,
        child: Card(
            color: appColorDarkBlue,
            child: Container(
              decoration: BoxDecoration(
                  color: appColorBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Image.asset(
                      Images.fearGreedIndex,
                      height: 40,
                    ),
                  ),
                  Text(
                    'Market Mood Insight',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}

Widget AdvanceDeclineCard(List<AdvanceDeclineModelData> advanceDecline) {
  return Padding(
    padding: EdgeInsets.only(left: 10, top: 8, right: 10),
    child: InkWell(
      onTap: () => Get.to(() => AdvanceDeclineView(advanceDecline), fullscreenDialog: true),

      child: Container(
        height: 100,
        width: 100,
        child: Card(
            color: appColorDarkBlue,
            child: Container(
              decoration: BoxDecoration(
                  color: appColorBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(20),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        value: 0.655,
                        minHeight: 10,
                      )),
                  Text(
                    'Advance/Decline',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}

Widget StockHeatMapCard(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 10, top: 8, right: 10),
    child: GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => WebViewScreen(
                url:
                    'https://in.tradingview.com/heatmap/stock/?color=change&dataset=NIFTY50&group=sector&size=market_cap_basic',
                title: 'Stock HeatMap Insight')));
      },
      child: Container(
        height: 100,
        child: Card(
            color: appColorDarkBlue,
            child: Container(
              decoration: BoxDecoration(
                  color: appColorBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset(
                      Images.heatMap,
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      'Stock HeatMap\nInsight',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}
