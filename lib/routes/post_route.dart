import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kittens/models/podcast_item.dart';
import 'package:kittens/models/post.dart';
import 'package:kittens/services/podcasts_service.dart';

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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (data, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              snapshot.data[index].description,
                              textAlign: TextAlign.center,
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
                      ),
                    );
                  });
            }
            return Text("X");
          },
        ));
  }
}
