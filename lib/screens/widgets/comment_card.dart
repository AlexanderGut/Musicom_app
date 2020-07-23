import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/comment.dart';

class CommentCard extends StatelessWidget {

  final Comment comment;

  const CommentCard(this.comment);

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
                title: Text(comment.user.name),
                contentPadding: EdgeInsets.all(10),
                subtitle: Text(comment.comment),
              ),
            ],
          )
      ),
    );
  }
}