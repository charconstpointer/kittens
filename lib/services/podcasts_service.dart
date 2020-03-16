import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kittens/models/podcasts/podcast_item.dart';

import 'package:kittens/models/post.dart';
import 'package:http/http.dart' as http;

class PodcastsService {
  final String url;

  PodcastsService({@required this.url});

  Future<List<Post>> getPodcasts() async {
    var response = await http.get(url);
    if (response.statusCode != 200) {
      print(response.statusCode);
      return null;
    }
    var decoded = json.decode(response.body)['items'];
    return (decoded as List).map((post) => Post.fromJson(post)).toList();
  }

  Future<List<PodcastItem>> getPodcastItems(int id) async {
    print(url + "/$id");
    var response = await http.get(url + "/$id");
    if (response.statusCode != 200) {
      print(response.statusCode);
      return null;
    }
    var decoded = json.decode(response.body)['items'];
    return (decoded as List).map((post) => PodcastItem.fromJson(post)).toList();
  }
}
