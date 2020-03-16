// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    isPlayable: json['isPlayable'] as bool,
    image: json['image'] == null
        ? null
        : PodcastImage.fromJson(json['image'] as Map<String, dynamic>),
  )..items = json['items'] as List;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isPlayable': instance.isPlayable,
      'image': instance.image,
      'items': instance.items,
    };
