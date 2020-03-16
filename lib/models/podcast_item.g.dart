// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastItem _$PodcastItemFromJson(Map<String, dynamic> json) {
  return PodcastItem(
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$PodcastItemToJson(PodcastItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };
