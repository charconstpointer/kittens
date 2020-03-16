import 'package:kittens/models/post.dart';

class Podcast extends Post {
  Podcast({id, title, description, image})
      : super(
            id: id,
            title: title,
            description: description,
            isPlayable: true,
            image: image);
}
