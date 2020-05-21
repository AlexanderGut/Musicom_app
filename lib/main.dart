import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/welcome_screen.dart';

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
    if (user == null) {
      return WelcomeScreen();
    }
    return WelcomeScreen(); // añadir otro home
  }
}

