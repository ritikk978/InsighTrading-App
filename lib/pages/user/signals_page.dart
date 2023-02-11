import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insigh/utils/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:insigh/components/z_card.dart';
import 'package:insigh/components/z_signal_subscribe.dart';
import 'package:insigh/models/signal.dart';
import 'package:insigh/models_providers/app_provider.dart';
import 'package:insigh/models_providers/auth_provider.dart';
import 'package:insigh/pages/user/signals_closed_page.dart';

import '../../components/z_signal_card.dart';
import '../../constants/images.dart';
import '../../models/auth_user.dart';
import '../../constants/app_colors.dart';

class SignalsPage extends StatefulWidget {
  SignalsPage({Key? key}) : super(key: key);

  @override
  State<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  String search = '';
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      Provider.of<AppProvider>(context, listen: false).updateLivePriceForSignals(Provider.of<AppProvider>(context, listen: false).signals);
    });
    super.initState();
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
    final signals = appProvider.signals;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: AvatarGlow(
          endRadius: 80.0,
          child: Material(     // Replace this child with your own
            elevation: 8.0,
            shape: CircleBorder(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),//or 15.0
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),//or 15.0
                    border: Border.all(color: appColorBlue, width: 2)
                ),
                height: 40.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    Images.logoWithNameImage,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          SizedBox(width: 20),
          Center(
            child: ZCard(
              onTap: (() => Get.to(() => SignalsClosedPage(), fullscreenDialog: true, duration: Duration(milliseconds: 500))),
              color: Colors.transparent,
              child: Text('Results', style: TextStyle(fontSize: 18, color: appColorBlue, fontWeight: FontWeight.w700)),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: signals.length,
                  itemBuilder: ((context, index) => getSignalCardType(signals[index])),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getSignalCardType(Signal signal) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AuthUser authUser = authProvider.authUser!;

    if (authUser.hasActiveSubscription) return ZSignalCard(true, signal: signal);
    if (signal.isFree) return ZSignalCard(true, signal: signal);
    return ZSignalSubscribeCard(signal: signal);
  }
}
