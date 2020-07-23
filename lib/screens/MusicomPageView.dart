import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/posts_screen.dart';
import 'package:musicomapp/screens/user_list_screen.dart';
import 'package:musicomapp/screens/user_profile_screen.dart';

class MusicomPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(
          initialPage: 2,

        ),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          PostsScreen(),
          UserListScreen(),
          UserProfileScreen(profileId: User.getInstance().profileId)
        ],
      ),
    );
  }
}