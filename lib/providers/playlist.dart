import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kittens/models/podcasts/podcast_item.dart';

class Playlist extends ChangeNotifier {
  List<PodcastItem> _items = [];
  UnmodifiableListView<PodcastItem> get items => UnmodifiableListView(_items);

  void addItem(PodcastItem item) {
    if (!_items.contains(item)) {
      print("added");
      _items.add(item);
      notifyListeners();
    }
  }
}
