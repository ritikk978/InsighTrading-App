import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_control.g.dart';

@JsonSerializable(explicitToJson: true)
class AppControl {
  @JsonKey(defaultValue: '')
  String appStoreLinkAndroid;
  @JsonKey(defaultValue: '')
  String appStoreLinkIOS;
  @JsonKey(defaultValue: 0)
  num appBuildNumberIOS;
  @JsonKey(defaultValue: 0)
  num appBuildNumberIOSMin;
  @JsonKey(defaultValue: 0)
  num appBuildNumberAndroid;
  @JsonKey(defaultValue: 0)
  num appBuildNumberAndroidMin;
  @JsonKey(defaultValue: '')
  String appStoreUpdateNotesAndroid;
  @JsonKey(defaultValue: '')
  String appStoreUpdateNotesIOS;
  @JsonKey(defaultValue: '')
  String youtubeUrl;

  AppControl()
      : appStoreLinkAndroid = '',
        appStoreLinkIOS = '',
        appBuildNumberIOS = 0,
        appBuildNumberIOSMin = 0,
        appBuildNumberAndroid = 0,
        appBuildNumberAndroidMin = 0,
        appStoreUpdateNotesAndroid = '',
        appStoreUpdateNotesIOS = '',
        youtubeUrl = '';

  factory AppControl.fromJson(Map<String, dynamic> json) => _$AppControlFromJson(json);
  Map<String, dynamic> toJson() => _$AppControlToJson(this)..remove('id');

  //NOTE functions
  Future<bool> isAppUpdateAvailableForce() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

    print('appBuildNumber: $appBuildNumber');

    if (Platform.isAndroid) {
      if (appBuildNumber < appBuildNumberAndroidMin) return true;
    }

    if (Platform.isIOS) {
      if (appBuildNumber < appBuildNumberIOSMin) return true;
    }

    return false;
  }

  Future<bool> isAppUpdateAvailable() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    num appBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;

    if (Platform.isAndroid) {
      if (appBuildNumber < appBuildNumberAndroid) return true;
    }

    if (Platform.isIOS) {
      if (appBuildNumber < appBuildNumberIOS) return true;
    }

    return false;
  }
}
