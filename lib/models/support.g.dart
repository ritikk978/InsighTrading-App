// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Support _$SupportFromJson(Map<String, dynamic> json) => Support()
  ..id = json['id'] as String? ?? ''
  ..name = json['name'] as String? ?? ''
  ..email = json['email'] as String? ?? ''
  ..message = json['message'] as String? ?? ''
  ..timestampCreated = parseToDateTime(json['timestampCreated']);

Map<String, dynamic> _$SupportToJson(Support instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'message': instance.message,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
    };
