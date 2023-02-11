import 'package:insigh/components/z_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

class ZGetUtils {
  static BuildContext context = Get.overlayContext!;

  static showToastSuccess({required String message, Duration? duration}) {
    showToastWidget(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 75),
        decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)), color: Color(0xFF5EEDA5)),
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
}
