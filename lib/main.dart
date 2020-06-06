import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/profile_screen.dart';
import 'package:musicomapp/screens/register_profile_screen.dart';
import 'package:musicomapp/screens/register_screen.dart';
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
      home: _initialScreen(),
    );
  }

  _initialScreen() {
    User user = User.getInstance();
    if (user.profileId == null) {
      return WelcomeScreen();
    }
    var puser = Profile(name: "Alexander", lastName: "Gutiérrez", status: "Hola pirinola");
    return ProfileScreen(profileId: user.profileId); // añadir otro home
  }
}

