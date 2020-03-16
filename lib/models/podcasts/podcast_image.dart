import 'package:json_annotation/json_annotation.dart';
part 'podcast_image.g.dart';

@JsonSerializable()
class PodcastImage {
  final String main;
  PodcastImage({this.main});

  factory PodcastImage.fromJson(Map<String, dynamic> json) =>
      _$PodcastImageFromJson(json);
}
