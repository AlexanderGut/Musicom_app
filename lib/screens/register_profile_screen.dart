import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/MusicomPageView.dart';
import 'package:musicomapp/screens/profile_screen.dart';
import 'package:musicomapp/screens/user_list_screen.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/services/profile_service.dart';

///
class RegisterProfileScreen extends StatefulWidget {

  @override
  _RegisterProfileScreen createState() => _RegisterProfileScreen();
}

class _RegisterProfileScreen extends State<RegisterProfileScreen> {
  User user;
  List _instruments = [
    "", "Acordeón", "Armónica", "Arpa", "Bajo", "Batería", "Bodhrán", "Castañuelas",
    "Cajón", "Charango", "Clarinete", "Contrabajo", "Cuatro"
  ];

  List _styles = [
    "Bachata", "Baladas", "Blues", "Bolero", "Bosa Nova", "Celta", "Clásica",
    "Corrido", "Country", "Criollo", "Cumbia", "Disco", "Dubstep", "Electrónica",
    "Flamenco", "Folk", "Funk", "Garage Rock", "Gospel", "Heavy Metal", "Hip Hop",
    "Indie", "Jazz", "Merengue", "Polka", "Pop", "Punk", "Ranchera", "Rap", "Reggae",
    "Reggaeton", "Rumba", "Rhythm and Blues", "Rock", "Rock and Roll", "Salsa",
    "Samba", "Ska", "Son", "Soul", "Swing", "Tango", "Trap", "Trova", "Vals", "Vallenato"
  ];

  String _currentValue = "";
  List<DropdownMenuItem<String>> _dropdownItems;
  List<String> styles = List();
  @override
  void initState() {
    super.initState();
    user = User.getInstance();
    _dropdownItems = initDropdownItems();
    _currentValue = _instruments[0];
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
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    "¡Bienvenido ${user.name}!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Cuentanos un poco sobre ti",
                  )
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 17),
                    child: Text("Instrumento principal: "),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  DropdownButton(
                    value: _currentValue,
                    items: _dropdownItems,
                    onChanged: changedDropdownItem,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 17, right: 10, top: 10),
              child: Text("Estilos que dominas:"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 17, right: 10, top: 10),
              child: Wrap(
                children: stylesTag(),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 60)),
            Container(
              height: 40,
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.bottomCenter,
              child: ButtonTheme(
                minWidth: 140,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.purple,
                  child: Text("Finalizar"),
                  onPressed: finalizar,
                ),
              )
            )
          ],
        )
      )
    );
  }

  stylesTag() {
    List<Widget> tags = List();
    for (var style in _styles) {
      tags.add(
        TagButton(tag: style, pressed: false, onPressed: () {
          if (!styles.contains(style)) {
            styles.add(style);
          } else {
            styles.remove(style);
          }
        }
      ));
    }
    return tags;
  }
  initDropdownItems() {
    List<DropdownMenuItem<String>> items = List();
    for (var instrument in _instruments) {
      items.add(DropdownMenuItem(value: instrument, child: Text(instrument)));
    }
    print(items.length);
    return items;
  }

  void changedDropdownItem(String instrument) {
    setState(() {
      _currentValue = instrument;
    });
  }

  void finalizar() async {
    Profile userProfile = Profile(
      id: user.profileId,
      name: user.name,
      lastName: user.lastName,
      principalInstrument: _currentValue,
      styles: styles
    );

    await ProfileService.updateProfile(
        user.profileId,
        <String, dynamic> {
          'principal_instrument': _currentValue,
          'music_styles': styles
        }
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MusicomPageView()
      )
    );
  }
}