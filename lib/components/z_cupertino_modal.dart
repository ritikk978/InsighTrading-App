import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'z_card.dart';

class ZModalCupertino {
  static Future showBottomSheet({required BuildContext context, required Widget child, String? title, bool showDone = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    final action = showDone ? Text('Done', style: TextStyle(fontWeight: FontWeight.bold)) : Icon(AntDesign.closecircle);
    return showCupertinoModalBottomSheet(
      enableDrag: false,
      context: Get.context!,
      builder: (context) => Material(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 16),
                  if (title != null) Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  ZCard(
                    color: Colors.transparent,
                    onTap: () => Get.back(),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(50),
                    child: action,
                  )
                ],
              ),
              SizedBox(height: 4),
              Divider(height: 0),
              Container(height: Get.height * .9, child: child)
            ],
          ),
        ),
      ),
    );
  }

  static Future showBottomSheetConfirm({required BuildContext context, required Widget child, String? title, bool showDone = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    final action = showDone ? Text('Done', style: TextStyle(fontWeight: FontWeight.bold)) : Icon(AntDesign.closecircle);
    return showCupertinoModalBottomSheet(
      enableDrag: false,
      context: Get.context!,
      builder: (context) => Material(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 16),
                  if (title != null) Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  ZCard(
                    color: Colors.transparent,
                    onTap: () => Get.back(),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(50),
                    child: action,
                  )
                ],
              ),
              SizedBox(height: 4),
              Divider(height: 0),
              Container(height: Get.height * .2, child: child)
            ],
          ),
        ),
      ),
    );
  }
}
