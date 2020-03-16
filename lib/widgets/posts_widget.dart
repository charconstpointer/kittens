import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kittens/models/post.dart';
import 'package:kittens/routes/post_route.dart';
import 'package:kittens/services/podcasts_service.dart';
import 'package:kittens/widgets/post_widget.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Future<List<Post>> _posts;
  @override
  void initState() {
    var podcastsService = PodcastsService(
        url: "https://podcasts.polskieradio.pl/api/podcasts?page=4");
    _posts = podcastsService.getPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (data, index) {
                  return SinglePost(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostRoute(
                                  post: snapshot.data[index],
                                )),
                      );
                    },
                    post: snapshot.data[index],
                    index: index,
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
