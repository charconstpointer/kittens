import 'package:json_annotation/json_annotation.dart';
import 'package:kittens/models/podcasts/podcast_image.dart';
import 'package:kittens/models/podcasts/podcast_item.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final String title;
  final String description;
  final bool isPlayable;
  final PodcastImage image;
  List<PodcastItem> items;
  Post({this.id, this.title, this.description, this.isPlayable, this.image});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
