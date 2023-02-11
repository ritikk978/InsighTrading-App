import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/images.dart';

PreferredSizeWidget InsighTradingAppBar({required List<Widget> actions}){
  return AppBar(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.transparent,
    title: AvatarGlow(
      endRadius: 200.0,
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
            height: 50.0,
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
    actions: actions,
  );
}