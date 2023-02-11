import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'z_card.dart';

class ZBottomSheet {
  static showBottomSheet({required BuildContext context, required Widget child, String? title}) {
    return Get.bottomSheet(Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              if (title != null) Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              ZCard(
                  onTap: () => Get.back(),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(50),
                  child: Icon(AntDesign.closecircle, color: Colors.blue))
            ],
          ),
          Container(height: Get.height * .51, child: child)
        ],
      ),
    ));
  }
}
