// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_control_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppControlLinks _$AppControlLinksFromJson(Map<String, dynamic> json) =>
    AppControlLinks()
      ..id = json['id'] as String? ?? ''
      ..appStore = json['appStore'] as String? ?? ''
      ..facebook = json['facebook'] as String? ?? ''
      ..googlePlay = json['googlePlay'] as String? ?? ''
      ..instagram = json['instagram'] as String? ?? ''
      ..support = json['support'] as String? ?? ''
      ..telegram = json['telegram'] as String? ?? ''
      ..twitter = json['twitter'] as String? ?? ''
      ..youtube = json['youtube'] as String? ?? ''
      ..whatsapp = json['whatsapp'] as String? ?? ''
      ..terms = json['terms'] as String? ?? ''
      ..privacy = json['privacy'] as String? ?? '';

Map<String, dynamic> _$AppControlLinksToJson(AppControlLinks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appStore': instance.appStore,
      'facebook': instance.facebook,
      'googlePlay': instance.googlePlay,
      'instagram': instance.instagram,
      'support': instance.support,
      'telegram': instance.telegram,
      'twitter': instance.twitter,
      'youtube': instance.youtube,
      'whatsapp': instance.whatsapp,
      'terms': instance.terms,
      'privacy': instance.privacy,
    };
