import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';

import '../post_screen.dart';

class PostCard extends StatelessWidget {

  final Post post;

  const PostCard(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                child: CachedNetworkImage(
                  imageUrl: "https://i.imgur.com/BoN9kdC.png", // user.imageUrl
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: imageProvider
                      )
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(post.title),
              contentPadding: EdgeInsets.all(10),
              onTap: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PostScreen(post: post))
                );
              },
            ),
            Container(
              color: Colors.grey.withAlpha(60),
              width: MediaQuery.of(context).size.width*0.87,
              margin: EdgeInsets.only(left: 27, bottom: 10),
              padding: EdgeInsets.all(5),
              child: Wrap(
                children: _tags(),
              ),
            )
          ],
        ),
      ),
    );
  }
  _tags() {
    List<Widget> tags = List();
    for (var t in post.tags) {
      tags.add(TagButton(tag: t));
    }
    return tags;
  }
}