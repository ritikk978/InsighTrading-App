// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement()
  ..id = json['id'] as String? ?? ''
  ..title = json['title'] as String? ?? ''
  ..body = json['body'] as String? ?? ''
  ..image = json['image'] as String? ?? ''
  ..link = json['link'] as String? ?? ''
  ..timestampCreated = parseToDateTime(json['timestampCreated'])
  ..timestampUpdated = parseToDateTime(json['timestampUpdated']);

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'image': instance.image,
      'link': instance.link,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
      'timestampUpdated': parseToDateTime(instance.timestampUpdated),
    };
