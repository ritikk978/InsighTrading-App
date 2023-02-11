
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insigh/utils/z_format.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/signal.dart';
import '../models_providers/theme_provider.dart';
import 'color_constants.dart';

double calculateLtpPrice(double nseLtpPrice, double bseLtpPrice) {
  return (nseLtpPrice != 0.0) ? nseLtpPrice : bseLtpPrice;
}

calculateTotalGain(double ltpPrice, num entry) {
  return ((ltpPrice - entry)/entry) * 100;
}

// Color getBottomNavigationColor(BuildContext context) {
// return Provider.of<ThemeProvider>(context).darkTheme ? Color(0xFF13192f) : Colors.white;
// }

getPercentChangeColor(double price){
  return price > 0 ? AppColors.livePriceGreenColor : appColorRed;
}

buildTradeStatusContainer({required String text, required bool isProfit, bool isInProgress = false}) {
  if (isInProgress)
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Text(text, style: TextStyle(color: AppColors.inProgressTextColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: isProfit ? Color(0xFF12533B).withOpacity(.6) : Color(0XFF332229),
    ),
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Row(
      children: [
        Text(text, style: TextStyle(color: isProfit ? Colors.white : Color(0xFFFF637E), fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(width: 4),
        Icon(isProfit ? Icons.check : Icons.close, color: Colors.white, size: 12),
      ],
    ),
  );
}

String getStatusText(Signal signal) {
  if (signal.isTakeProfit3Hit) return 'All target achieved @ ${ZFormat.dateFormatStr(signal.takeProfit3Datetime)}';
  if (signal.isTakeProfit2Hit) return 'Target 2 achieved @ ${ZFormat.dateFormatStr(signal.takeProfit2Datetime)}';
  if (signal.isTakeProfit1Hit) return 'Target 1 achieved @ ${ZFormat.dateFormatStr(signal.takeProfit1Datetime)}';
  if (signal.isStopLossHit) return 'Stoploss hit @ ${ZFormat.dateFormatStr(signal.stopLossDatetime)}';
  return 'In progress';
}