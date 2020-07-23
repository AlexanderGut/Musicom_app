import 'package:flutter/material.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/MusicomPageView.dart';
import 'package:musicomapp/screens/login_screen.dart';
import 'package:musicomapp/screens/new_post_screen.dart';
import 'package:musicomapp/screens/post_screen.dart';
import 'package:musicomapp/screens/posts_screen.dart';
import 'package:musicomapp/screens/profile_screen.dart';
import 'package:musicomapp/screens/register_profile_screen.dart';
import 'package:musicomapp/screens/register_screen.dart';
import 'package:musicomapp/screens/user_list_screen.dart';
import 'package:musicomapp/screens/welcome_screen.dart';

import 'models/profile.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  User.getData().then((value) => runApp(Musicom()));
}
// Clase principal de la aplicación
//
// La clase Musicom engloba todas las subclases de la aplicación
class Musicom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musicom App',
      home: _initialScreen(),
    );
  }

  // Función que evalua el screen inicial
  //
  // Esta función comprueba si existen datos guardados del usuario,
  // desplegando el screen de welcome en caso de que no existan datos y
  // despliega profile_screen en caso de que los datos existen.
  _initialScreen() {
    User user = User.getInstance();
    if (user.profileId == null) {
      return WelcomeScreen();
    }
    return MusicomPageView(); // añadir otro home
  }
}

