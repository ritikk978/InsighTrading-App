import 'package:json_annotation/json_annotation.dart';

import '_parsers.dart';

part 'signal.g.dart';

@JsonSerializable(explicitToJson: true)
class Signal {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String symbol;
  @JsonKey(defaultValue: 0)
  num entry;
  @JsonKey(defaultValue: '')
  String finCode;
  @JsonKey(defaultValue: 0)
  num stopLoss;
  //
  @JsonKey(defaultValue: 0)
  num takeProfit1;
  @JsonKey(defaultValue: 0)
  num takeProfit2;
  @JsonKey(defaultValue: 0)
  num takeProfit3;
  //
  @JsonKey(defaultValue: false)
  bool isStopLossHit;
  @JsonKey(defaultValue: false)
  bool isTakeProfit1Hit;
  @JsonKey(defaultValue: false)
  bool isTakeProfit2Hit;
  @JsonKey(defaultValue: false)
  bool isTakeProfit3Hit;
  //
  @JsonKey(defaultValue: '')
  String comment;
  @JsonKey(defaultValue: '')
  String market;
  @JsonKey(defaultValue: '')
  String entryType;
  @JsonKey(defaultValue: '')
  String entryPipsPercentage;
  @JsonKey(defaultValue: '')
  String image;
  @JsonKey(defaultValue: '')
  String analysisText;
  @JsonKey(defaultValue: 0)
  double ltpPrice;
  @JsonKey(defaultValue: 0)
  double changePercent;
  //
  @JsonKey(defaultValue: true)
  bool isActive;
  @JsonKey(defaultValue: false)
  bool isFree;
  //
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? entryDatetime;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? stopLossDatetime;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? takeProfit1Datetime;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? takeProfit2Datetime;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? takeProfit3Datetime;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampUpdated;

  Signal()
      : id = '',
        entry = 0,
        stopLoss = 0,
        isStopLossHit = false,
        takeProfit1 = 0,
        takeProfit2 = 0,
        takeProfit3 = 0,
        isTakeProfit1Hit = false,
        isTakeProfit2Hit = false,
        isTakeProfit3Hit = false,
        image = '',
        symbol = '',
        comment = '',
        entryType = '',
        finCode = '',
        entryPipsPercentage = '',
        analysisText = '',
        ltpPrice = 0,
        changePercent = 0,
        market = '',
        isActive = true,
        isFree = false,
        timestampCreated = null,
        timestampUpdated = null,
        entryDatetime = null,
        stopLossDatetime = null,
        takeProfit1Datetime = null,
        takeProfit2Datetime = null,
        takeProfit3Datetime = null;

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);
  Map<String, dynamic> toJson() => _$SignalToJson(this)..remove('id');

  // functions
  get hasAnalysis {
    if (analysisText != '' || image != '') return true;
    return false;
  }

  String get getTakeProfit1PipsOrPercentage {
    num val = (takeProfit1 - entry).abs();
    if (takeProfit1 == 0) return 'N/A';

    if (entryPipsPercentage == 'Percentage')
      return '${(val / entry * 100).toStringAsFixed(2)}%';

    val = val * 10000;
    return '${val.toStringAsFixed(0)} Pips';
  }

  String get getTakeProfit2PipsOrPercentage {
    num val = (takeProfit2 - entry).abs();
    if (takeProfit2 == 0) return 'N/A';

    if (entryPipsPercentage == 'Percentage')
      return '${(val / entry * 100).toStringAsFixed(2)}%';

    val = val * 10000;
    return '${val.toStringAsFixed(0)} Pips';
  }

  String get getTakeProfit3PipsOrPercentage {
    num val = (takeProfit3 - entry).abs();
    if (takeProfit3 == 0) return 'N/A';

    if (entryPipsPercentage == 'Percentage')
      return '${(val / entry * 100).toStringAsFixed(2)}%';

    val = val * 10000;
    return '${val.toStringAsFixed(0)} Pips';
  }

  String get getStopLossPipsOrPercentage {
    num val = (stopLoss - entry).abs();
    if (entryPipsPercentage == 'Percentage')
      return '${(val / entry * 100).toStringAsFixed(2)}%';

    val = val * 10000;
    return '${val.toStringAsFixed(0)} Pips';
  }
}
