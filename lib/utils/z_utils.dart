import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:insigh/models/app_control.dart';

import 'package:url_launcher/url_launcher.dart';

import '../components/z_card.dart';

class ZUtils {
  static BuildContext context = Get.overlayContext!;

  static showToastSuccess({required String message, Duration? duration}) {
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 75),
        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)), color: Colors.white),
        child: Text(message, style: TextStyle(color: Colors.black87)),
      ),
      context: context,
      animation: StyledToastAnimation.fadeScale,
      reverseAnimation: StyledToastAnimation.fade,
      animDuration: Duration(seconds: 1),
      duration: duration ?? Duration(seconds: 4),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linear,
    );
  }

  static showToastError({required String message, Duration? duration}) {
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 75),
        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)), color: Colors.red[300]),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
      context: context,
      animation: StyledToastAnimation.fadeScale,
      reverseAnimation: StyledToastAnimation.fade,
      animDuration: Duration(seconds: 1),
      duration: duration ?? Duration(seconds: 4),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.linear,
    );
  }

  static showDialogConfirm({required GestureTapCallback onTapConfirm, GestureTapCallback? onTapCancel, String? message, String? subTitle}) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final cardColor = isLightTheme ? Colors.white : Color(0xFF29313C);

    showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                width: Get.width * .8,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: cardColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message ?? 'Are you sure you want to proceed?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5)),
                    SizedBox(height: 12),
                    Text(
                      subTitle ?? "Once you proceed with this action it can't be undone.",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.5, color: Theme.of(context).textTheme.caption!.color),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ZCard(
                          color: Colors.transparent,
                          margin: EdgeInsets.zero,
                          onTap: () {
                            Get.back();
                            if (onTapCancel != null) onTapCancel();
                          },
                          child: Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 14)),
                        ),
                        SizedBox(width: 8),
                        ZCard(
                          color: Colors.transparent,
                          margin: EdgeInsets.zero,
                          onTap: () {
                            Get.back();
                            onTapConfirm();
                          },
                          child: Text('Confirm', style: TextStyle(color: Colors.blue, fontSize: 14)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: false,
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  static showUpdateDialogue({required AppControl appControl, bool isForceUpdate = false}) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final cardColor = isLightTheme ? Colors.white : Color(0xFF29313C);

    String updateMessage = Platform.isAndroid ? appControl.appStoreUpdateNotesAndroid : appControl.appStoreUpdateNotesIOS;
    String storeLink = Platform.isAndroid ? appControl.appStoreLinkAndroid : appControl.appStoreLinkIOS;

    showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  child: Container(
                    width: Get.width * .8,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: cardColor),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Image.asset('assets/images/update_rocket.png', height: 60)),
                            Center(child: Text('App update available.', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.5))),
                            SizedBox(height: 2),
                            if (isForceUpdate)
                              Center(
                                  child: Text('This update is required.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        color: Theme.of(context).textTheme.caption!.color,
                                      ))),
                            SizedBox(height: 24),
                            splitUpdateTextColumn(message: updateMessage, context: context),
                            SizedBox(height: 32),
                            Center(
                              child: ZCard(
                                color: Color(0xFFF54B4B),
                                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                                margin: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  _launchURL(storeLink);
                                },
                                child: Text('Update', style: TextStyle(color: Colors.white, fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // if (isForceUpdate == false)
                Positioned(
                  right: -10,
                  top: 0,
                  child: ZCard(
                    padding: EdgeInsets.all(5),
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.grey.shade700, size: 16),
                  ),
                )
              ],
            ),
          ],
        );
      },
      barrierDismissible: isForceUpdate == false,
      animationType: DialogTransitionType.fadeScale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 500),
      barrierColor: Colors.black.withOpacity(0.8),
    );
  }
}

void _launchURL(String url) async {
  await canLaunchUrl(Uri(scheme: 'https', host: url)) ? await launchUrl(Uri(scheme: 'https', host: url)) : throw 'Could not launch $url';
}

splitUpdateTextColumn({required String message, required BuildContext context}) {
  List<String> splitText = message.split('*');
  splitText = splitText.map((e) => e.trim()).toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var item in splitText)
        Text(
          item,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 1.6,
            color: Theme.of(context).textTheme.caption!.color,
          ),
        ),
    ],
  );
}
