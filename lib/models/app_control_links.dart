import 'package:json_annotation/json_annotation.dart';

part 'app_control_links.g.dart';

@JsonSerializable(explicitToJson: true)
class AppControlLinks {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String appStore;
  @JsonKey(defaultValue: '')
  String facebook;
  @JsonKey(defaultValue: '')
  String googlePlay;
  @JsonKey(defaultValue: '')
  String instagram;
  @JsonKey(defaultValue: '')
  String support;
  @JsonKey(defaultValue: '')
  String telegram;
  @JsonKey(defaultValue: '')
  String twitter;
  @JsonKey(defaultValue: '')
  String youtube;
  @JsonKey(defaultValue: '')
  String whatsapp;
  @JsonKey(defaultValue: '')
  String terms;
  @JsonKey(defaultValue: '')
  String privacy;

  AppControlLinks()
      : id = '',
        appStore = '',
        facebook = '',
        googlePlay = '',
        instagram = '',
        support = '',
        telegram = '',
        twitter = '',
        youtube = '',
        whatsapp = '',
        terms = '',
        privacy = '';

  factory AppControlLinks.fromJson(Map<String, dynamic> json) => _$AppControlLinksFromJson(json);
  Map<String, dynamic> toJson() => _$AppControlLinksToJson(this)..remove('id');
}
