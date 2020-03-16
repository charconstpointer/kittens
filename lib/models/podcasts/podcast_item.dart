import 'package:json_annotation/json_annotation.dart';
part 'podcast_item.g.dart';

@JsonSerializable()
class PodcastItem {
  final String title;
  final String description;

  PodcastItem({this.title, this.description});

  factory PodcastItem.fromJson(Map<String, dynamic> json) =>
      _$PodcastItemFromJson(json);
}
