import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kittens/models/post.dart';

class SinglePost extends StatelessWidget {
  final Post post;
  final index;
  final image;
  final onTap;
  SinglePost({this.post, this.index, this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            leading: Image.network(
              post.image.main,
              width: 100,
              height: 100,
              fit: BoxFit.fitWidth,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                );
              },
            ),
            title: Text(
              post.title,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(post.description.substring(0, 30)),
          )
        ],
      ),
    );
  }
}
