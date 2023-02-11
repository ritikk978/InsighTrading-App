import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/images.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final isBackButtonExist;
  final IconData? icon;
  final Function? onActionPressed;
  final Function? onBackPressed;

  CustomAppBar({this.title, this.isBackButtonExist = true, this.icon, this.onActionPressed, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [

      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 50,
        alignment: Alignment.center,
        child: Row(children: [

          isBackButtonExist ? IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
            onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.of(context).pop(),
          ) : SizedBox.shrink(),
          SizedBox(width: 8),

          Expanded(
            child: Text(
              title!, style: TextStyle(fontSize: 20, color: Colors.white),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),
          ),

          icon != null ? IconButton(
            icon: Icon(icon, size: 32, color: Colors.white),
            onPressed: (){Navigator.of(context).pop();},
          ) : SizedBox.shrink(),

        ]),
      ),
    ]);
  }
}
