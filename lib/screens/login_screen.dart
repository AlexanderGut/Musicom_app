import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/profile_screen.dart';
import 'package:musicomapp/screens/register_screen.dart';
import 'package:musicomapp/screens/user_list_screen.dart';
import 'package:musicomapp/services/auth_service.dart';
import 'package:musicomapp/services/profile_service.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _LoginScreen() {
    emailController.addListener(emailListener);
    passwordController.addListener(passwordListener);
  }

  void emailListener() {
    // email validation
  }

  void passwordListener() {
    //
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset("assets/images/logo.png", width: 100, height: 100)
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('¿Olvidaste tu contraseña?'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: Text('Iniciar sesión'),
                      onPressed: login
                    )
                ),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('¿Aún no tienes cuenta?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Regístrate',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen())
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )
        )
    );
  }

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (readyToLogin()){
      var res = await AuthService.login(email, password);
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserListScreen())
        );
      } else {
      }
    }
  }

  bool readyToLogin() {
    var email = emailController.text.isNotEmpty;
    var password = passwordController.text.isNotEmpty;
    if (!email) {
      Fluttertoast.showToast(
          msg: "El email no puede estar vacío",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 15.0);
    } else if (!password) {
        Fluttertoast.showToast(
            msg: "Ingrese la contraseña",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 15.0);
    }
    return email && password;
  }
}