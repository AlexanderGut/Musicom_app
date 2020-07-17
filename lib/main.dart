import 'package:flutter/material.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/new_post_screen.dart';
import 'package:musicomapp/screens/posts_screen.dart';
import 'package:musicomapp/screens/profile_screen.dart';
import 'package:musicomapp/screens/user_list_screen.dart';
import 'package:musicomapp/screens/welcome_screen.dart';

import 'models/profile.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  User.getData().then((value) => runApp(Musicom()));
}

class Musicom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musicom App',
      home: NewPostScreen(),
    );
  }

  _initialScreen() {
    User user = User.getInstance();
    if (user.profileId == null) {
      return WelcomeScreen();
    }
    return UserListScreen(); // añadir otro home
  }
}

