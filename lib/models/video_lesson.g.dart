// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoLesson _$VideoLessonFromJson(Map<String, dynamic> json) => VideoLesson()
  ..id = json['id'] as String? ?? ''
  ..image = json['image'] as String? ?? ''
  ..title = json['title'] as String? ?? ''
  ..link = json['link'] as String? ?? ''
  ..isFeatured = json['isFeatured'] as bool? ?? false
  ..isPremium = json['isPremium'] as bool? ?? false
  ..timestampCreated = parseToDateTime(json['timestampCreated']);

Map<String, dynamic> _$VideoLessonToJson(VideoLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'link': instance.link,
      'isFeatured': instance.isFeatured,
      'isPremium': instance.isPremium,
      'timestampCreated': parseToDateTime(instance.timestampCreated),
    };
