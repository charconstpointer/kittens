import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kittens/models/podcasts/podcast_item.dart';

import 'package:kittens/models/post.dart';
import 'package:kittens/providers/playlist.dart';
import 'package:kittens/services/podcasts_service.dart';
import 'package:provider/provider.dart';

class PostRoute extends StatefulWidget {
  final Post post;
  PostRoute({this.post});

  @override
  _PostRouteState createState() => _PostRouteState(post: post);
}

class _PostRouteState extends State<PostRoute> {
  Post post;
  Future<List<PodcastItem>> _items;

  _PostRouteState({this.post});
  var _podcastService =
      PodcastsService(url: "https://podcasts.polskieradio.pl/api/podcasts");
  @override
  void initState() {
    super.initState();
    setState(() {
      print(post.id);
      _items = _podcastService.getPodcastItems(post.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                        )
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "${post.title}",
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            "#${post.id}",
                            style: TextStyle(fontSize: 24),
                          ),
                          IconButton(
                            icon: Icon(Icons.sort),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (data, index) {
                          return buildPodcastItem(snapshot, index);
                        }),
                  )
                ],
              );
            }
            //loading??
            return Text("X");
          },
        ));
  }

  Padding buildPodcastItem(AsyncSnapshot snapshot, int index) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: Text(
                  snapshot.data[index].description,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _getScoring(5)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
                  IconButton(icon: Icon(Icons.add_comment), onPressed: () {}),
                  _buildFav(snapshot.data[index])
                ],
              ),
            )
          ],
          leading: Image.network(
            post.image.main,
            width: 100,
            height: 100,
            fit: BoxFit.fitWidth,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                  child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ));
            },
          ),
          title: Text(
            snapshot.data[index].title,
            style: TextStyle(fontSize: 18),
          ),
        ));
  }

  Widget _buildFav(PodcastItem item) {
    var isLiked = Provider.of<Playlist>(context, listen: false)
        .items
        .any((x) => x.title == item.title);
    return IconButton(
        icon: Icon(Icons.favorite),
        color: isLiked ? Colors.red : Colors.white,
        onPressed: () {
          setState(() {
            Provider.of<Playlist>(context, listen: false).addItem(item);
          });
        });
  }

  List<Widget> _getScoring(maxScore) {
    var random = Random();
    var score = random.nextInt(maxScore);
    var stars = List<Widget>();
    for (var i = 0; i < maxScore; i++) {
      if (i <= score) {
        stars.add(Icon(
          Icons.star,
          color: Theme.of(context).accentColor,
        ));
      } else {
        stars.add(Icon(
          Icons.star_border,
          color: Theme.of(context).dividerColor,
        ));
      }
    }
    return stars;
  }
}
