import 'package:json_annotation/json_annotation.dart';

import '_parsers.dart';

part 'announcement.g.dart';

@JsonSerializable(explicitToJson: true)
class Announcement {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(defaultValue: '')
  String body;
  @JsonKey(defaultValue: '')
  String image;
  @JsonKey(defaultValue: '')
  String link;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampCreated;
  @JsonKey(fromJson: parseToDateTime, toJson: parseToDateTime)
  DateTime? timestampUpdated;

  Announcement()
      : id = '',
        title = '',
        body = '',
        image = '',
        link = '',
        timestampCreated = null,
        timestampUpdated = null;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this)..remove('id');
}
