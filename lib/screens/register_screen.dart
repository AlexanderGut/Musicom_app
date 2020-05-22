import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/screens/login_screen.dart';
import 'package:musicomapp/screens/welcome_screen.dart';
import 'package:musicomapp/services/auth_service.dart';


class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  _RegisterScreen() {
    emailController.addListener(emailListener);
    firstNameController.addListener(firstNameListener);
    lastNameController.addListener(lastNameListener);
    passwordController.addListener(passwordListener);
    confirmPasswordController.addListener(confirmPasswordListener);
  }

  void emailListener() {
    //
  }

  void firstNameListener() {

  }

  void lastNameListener() {

  }

  void passwordListener() {
    //
  }

  void confirmPasswordListener() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset("assets/images/logo.png", width: 100, height: 100)
                ),
                Container(
                  //margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  height: 60,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(top: 10),
                  height: 60,

                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                    ),
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(top: 10),
                  height: 60,

                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Apellido',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  height: 60,

                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  height: 60,

                  child: TextField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirmar contraseña',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.purple,
                      child: Text('Registrar'),
                      onPressed: register
                    )
                ),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('¿Tienes ya una cuenta?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Inicia sesión',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()));
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

  register() async {
    String email = emailController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty &&
        firstName.isNotEmpty && lastName.isNotEmpty){
      if (password == confirmPassword) {
        var res = await AuthService.signup(email, firstName, lastName, password);
        if (res.statusCode == 200) {
          print(jsonDecode(res.body));
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()));
        } else {
          print(jsonDecode(res.body));
        }
      }
    }
  }
}