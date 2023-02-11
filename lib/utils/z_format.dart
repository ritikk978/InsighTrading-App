import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ZFormat {
  static String numToMoney(num number) {
    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    return '\$${currencyFormat.format(number)}';
  }

  static String strToMoney(String number) {
    final currencyFormat = new NumberFormat("#,##0.00", "en_US");
    return '\$${currencyFormat.format(num.tryParse(number) ?? 0)}';
  }

  static num toPrecision(num number, int fractionDigits) {
    if (number == double.nan) return 0;
    num mod = pow(10, fractionDigits);
    return ((number * mod).round() / mod);
  }

  static dateTimeFormatStr(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("MMM dd, yyyy 'at' h:mm a").format(dateTime);
  }

  static String numToPercent(num number) {
    return '${toPrecision(number * 100, 2)}%';
  }

  static dateFormatStr(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("MMM dd, yyyy").format(dateTime);
  }

  static dateFormatSignal(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("MMM dd, yyyy | h:mm a").format(dateTime);
  }

  static timeFormatStr(TimeOfDay? dateTime, BuildContext context) {
    if (dateTime == null) return '';
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute).format(context).toString();
  }
}
