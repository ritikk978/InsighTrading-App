// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_control.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppControl _$AppControlFromJson(Map<String, dynamic> json) => AppControl()
  ..appStoreLinkAndroid = json['appStoreLinkAndroid'] as String? ?? ''
  ..appStoreLinkIOS = json['appStoreLinkIOS'] as String? ?? ''
  ..appBuildNumberIOS = json['appBuildNumberIOS'] as num? ?? 0
  ..appBuildNumberIOSMin = json['appBuildNumberIOSMin'] as num? ?? 0
  ..appBuildNumberAndroid = json['appBuildNumberAndroid'] as num? ?? 0
  ..appBuildNumberAndroidMin = json['appBuildNumberAndroidMin'] as num? ?? 0
  ..appStoreUpdateNotesAndroid =
      json['appStoreUpdateNotesAndroid'] as String? ?? ''
  ..appStoreUpdateNotesIOS = json['appStoreUpdateNotesIOS'] as String? ?? ''
  ..youtubeUrl = json['youtubeUrl'] as String? ?? '';

Map<String, dynamic> _$AppControlToJson(AppControl instance) =>
    <String, dynamic>{
      'appStoreLinkAndroid': instance.appStoreLinkAndroid,
      'appStoreLinkIOS': instance.appStoreLinkIOS,
      'appBuildNumberIOS': instance.appBuildNumberIOS,
      'appBuildNumberIOSMin': instance.appBuildNumberIOSMin,
      'appBuildNumberAndroid': instance.appBuildNumberAndroid,
      'appBuildNumberAndroidMin': instance.appBuildNumberAndroidMin,
      'appStoreUpdateNotesAndroid': instance.appStoreUpdateNotesAndroid,
      'appStoreUpdateNotesIOS': instance.appStoreUpdateNotesIOS,
      'youtubeUrl': instance.youtubeUrl,
    };
