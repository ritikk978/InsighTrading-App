import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insigh/components/z_card.dart';
import 'package:insigh/utils/color_constants.dart';

import '../models/signal.dart';
import '../pages/user/subscription_page.dart';
import '../utils/z_format.dart';
import '../constants/app_colors.dart';

class ZSignalSubscribeCard extends StatefulWidget {
  ZSignalSubscribeCard({Key? key, required this.signal}) : super(key: key);
  final Signal signal;

  @override
  State<ZSignalSubscribeCard> createState() => _ZSignalSubscribeCardState();
}

class _ZSignalSubscribeCardState extends State<ZSignalSubscribeCard> {
  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
      // onTap: () => Get.to(() => SubscriptionPage()),
      padding: EdgeInsets.all(12),
      color: Colors.transparent,
      borderRadiusColor: isLightTheme ? Colors.grey.shade300 : Colors.white12,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: widget.signal.entryType == 'Sell' ? appColorRed : AppColors.tradeSuggestionCardColor, borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text('${widget.signal.entryType.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
                ),
                SizedBox(width: 6),
                Text(widget.signal.symbol, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, height: 0)),
                SizedBox(width: 6),
                Text(
                  '${ZFormat.dateFormatSignal(widget.signal.entryDatetime)}',
                  style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 11),
                ),
              ],
            ),
            ZCard(
              color: isLightTheme ? Colors.black54 : Colors.white,
              child: Text('Tap to join Premium', style: TextStyle(color: isLightTheme ? Colors.white : Colors.black)),
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 6),
            ),
          ],
        ),
      ),
    );
  }
}
