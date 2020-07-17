import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/profile.dart';

class UserCard extends StatelessWidget {

  final UserProfile user;

  const UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
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
          title: Text(user.name),
          subtitle: Text(user.status),
        ),
      ),
    );
  }
}