import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/screens/login_screen.dart';


class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  Widget _buttons() {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _loginButton(),
          _registerButton(),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return ButtonTheme(
      minWidth: 150,
      height: 40,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: RaisedButton(
          onPressed: () {},
          textColor: Colors.white,
          color: Colors.purple,
          child: Text(
            'Regístrate',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      )
    );
  }

  Widget _loginButton() {
    return ButtonTheme(
      minWidth: 150,
      height: 40,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => LoginScreen()));
          },
          textColor: Colors.white,
          color: Colors.purple,
          child: Text(
          'Iniciar sesión',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),
          ),
        ),
      ),
    );
//
  }

  Widget _logo() {
    return Container(
      margin: EdgeInsets.only(top: 190),
      child: Image.asset("assets/images/logo.png", width: 100, height: 100,),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Music\n",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [Colors.purple, Colors.red],
                end: Alignment.topRight,
              ).createShader(Rect.fromLTWH(40.0, 40.0, 40.0, 40.0)),
        ),
        children: [
          TextSpan(
            text: "Community",
            style: TextStyle(fontSize: 20)
          )
        ]
      ),
    );
  }

  Widget _text() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "¡Conéctate!\n Comienza a generar contactos\nen la escena musical.",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          //padding: EdgeInsets.symmetric(horizontal: 190),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.center,
                  colors: [Colors.deepPurpleAccent, Colors.white]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _logo(),
              _title(),
              _text(),
              _buttons()
            ],
          ),
        ),
    );
  }


}