import 'package:flutter/material.dart';
import 'package:insigh/components/screenshot_function.dart';
import 'package:insigh/components/z_signal_card.dart';
import 'package:insigh/models_services/dynamic_links_service.dart';
import 'package:share_plus/share_plus.dart';
import '../constants/app_colors.dart';
import '../models/signal.dart';

class ShareTradeButton extends StatelessWidget {
  Signal signal;
  //
  ShareTradeButton(this.signal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScreenshotController.captureFromWidget(
          ZSignalCard(false, signal: signal),
            pixelRatio : 2.0,
            targetSize: Size(
                MediaQuery.of(context).size.width,
                230),
            context: context,).then((value) {
              DynamicLinkService().createDynamicLink().then((deepLink) {
                Share.shareXFiles([XFile(value.path)],
                    text: "Hi, please check out latest stock insight of *${signal.symbol}* on *InsighTrading*. Download the app to know the target.👇🏻 ${deepLink.origin + deepLink.path}");

              });
        });
      },
      child: Container(
        decoration: BoxDecoration(
        ),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Center(
            child: Icon(Icons.share)),
      ),
    );
  }
}
