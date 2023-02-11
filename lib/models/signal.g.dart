// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signal _$SignalFromJson(Map<String, dynamic> json) => Signal()
  ..id = json['id'] as String? ?? ''
  ..symbol = json['symbol'] as String? ?? ''
  ..finCode = json['finCode'] as String? ?? ''
  ..entry = json['entry'] as num? ?? 0
  ..stopLoss = json['stopLoss'] as num? ?? 0
  ..takeProfit1 = json['takeProfit1'] as num? ?? 0
  ..takeProfit2 = json['takeProfit2'] as num? ?? 0
  ..takeProfit3 = json['takeProfit3'] as num? ?? 0
  ..isStopLossHit = json['isStopLossHit'] as bool? ?? false
  ..isTakeProfit1Hit = json['isTakeProfit1Hit'] as bool? ?? false
  ..isTakeProfit2Hit = json['isTakeProfit2Hit'] as bool? ?? false
  ..isTakeProfit3Hit = json['isTakeProfit3Hit'] as bool? ?? false
  ..comment = json['comment'] as String? ?? ''
  ..market = json['market'] as String? ?? ''
  ..entryType = json['entryType'] as String? ?? ''
  ..entryPipsPercentage = json['entryPipsPercentage'] as String? ?? ''
  ..image = json['image'] as String? ?? ''
  ..analysisText = json['analysisText'] as String? ?? ''
  ..isActive = json['isActive'] as bool? ?? true
  ..isFree = json['isFree'] as bool? ?? false
  ..entryDatetime = parseToDateTime(json['entryDatetime'])
  ..stopLossDatetime = parseToDateTime(json['stopLossDatetime'])
  ..takeProfit1Datetime = parseToDateTime(json['takeProfit1Datetime'])
  ..takeProfit2Datetime = parseToDateTime(json['takeProfit2Datetime'])
  ..takeProfit3Datetime = parseToDateTime(json['takeProfit3Datetime'])
  ..timestampCreated = parseToDateTime(json['timestampCreated'])
  ..timestampUpdated = parseToDateTime(json['timestampUpdated']);

Map<String, dynamic> _$SignalToJson(Signal instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'finCode': instance.finCode,
      'entry': instance.entry,
      'stopLoss': instance.stopLoss,
      'takeProfit1': instance.takeProfit1,
      'takeProfit2': instance.takeProfit2,
      'takeProfit3': instance.takeProfit3,
      'isStopLossHit': instance.isStopLossHit,
      'isTakeProfit1Hit': instance.isTakeProfit1Hit,
      'isTakeProfit2Hit': instance.isTakeProfit2Hit,
      'isTakeProfit3Hit': instance.isTakeProfit3Hit,
      'comment': instance.comment,
      'market': instance.market,
      'entryType': instance.entryType,
      'entryPipsPercentage': instance.entryPipsPercentage,
      'image': instance.image,
      'analysisText': instance.analysisText,
      'isActive': instance.isActive,
      'isFree': instance.isFree,
      'entryDatetime': parseToDateTime(instance.entryDatetime),
      'stopLossDatetime': parseToDateTime(instance.stopLossDatetime),
      'takeProfit1Datetime': parseToDateTime(instance.takeProfit1Datetime),
      'takeProfit2Datetime': parseToDateTime(instance.takeProfit2Datetime),
      'takeProfit3Datetime': parseToDateTime(instance.takeProfit3Datetime),
      'timestampCreated': parseToDateTime(instance.timestampCreated),
      'timestampUpdated': parseToDateTime(instance.timestampUpdated),
    };
