import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/welcome_screen.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/services/profile_service.dart';


class UserProfileScreen extends StatefulWidget {
  final String profileId;

  UserProfileScreen({Key key, @required this.profileId}) : super(key: key);

  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {

  Profile user;
  String profileId;
  bool _load = false;
  bool _waiting = false;
  TextEditingController newStatusController = TextEditingController();
  TextEditingController newBioController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Profile user;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: CurvePainter(),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: FutureBuilder(
                    builder: (context, i) {
                      if (!_load || !_waiting) {
                        _waiting = true;
                        if (User.getInstance().profileId != null) {
                          ProfileService.fetchProfile(User.getInstance().profileId)
                              .then((value) {
                            this.setState(() {
                              print(value);
                              user = value;
                              _load = true;
                            });
                          });
                        } else if (profileId.isNotEmpty) {
                          ProfileService.fetchProfile(profileId)
                              .then((value) {
                            this.setState(() {
                              print(value);
                              user = value;
                              _load = true;
                            });
                          });
                        }
                      }
                      if (user != null) {
                        return ListView(
                            children: [
                              headProfile(),
                              divider(),
                              bioInfo(),
                              divider(),
                              instrument(),
                              divider(),
                              styles(),
                              divider(),
                              media(),
                              divider(),
                              contact()
                            ]
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                )
            )
        ),
      ),
    );
  }

  divider() {
    return Divider(
      color: Colors.black26.withAlpha(40),
      height: 15,
      thickness: 1,
      indent: 10,
      endIndent: 10,
    );
  }

  headProfile() {
    return Container(
      height: 250,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white,),
              onPressed: () {
                User.removeData();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen())
                );
              },
            ),
          ),
          Center(
            child: Container(
                width: 110,
                height: 110,
                child: image()
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "${user.name} ${user.lastName}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  user.status != null ? user.status : "estado",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, size: 18,),
                  onPressed: () => newStatusDialog(context)
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  bioInfo() {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                    "Bio:",
                    textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 18,),
                      onPressed: () => newBioDialog(context),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                  user.bio != null ? user.bio : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic
                  )
              )
            ]
        )
    );
  }

  media() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Media:",
              style: TextStyle(
                  fontWeight: FontWeight.w700
              )
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                    FontAwesomeIcons.youtube
                ),
                onPressed: () => {},
              ),
              IconButton(
                icon: FaIcon(
                    FontAwesomeIcons.instagram
                ),
                onPressed: () => {},
              )
            ],
          )
        ],
      ),
    );
  }

  instrument() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Instrumento principal:",
            style: TextStyle(
                fontWeight: FontWeight.w700
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
              user.principalInstrument
          )
        ],
      ),
    );
  }

  styles() {
    return Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Estilos:",
                style: TextStyle(
                    fontWeight: FontWeight.w700
                )
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Wrap(
              children: stylesTag(user.styles),
            )
          ],
        )
    );
  }

  stylesTag(List<String> styles) {
    List<Widget> list = List();
    for (var s in styles) {
      list.add(TagButton(tag: s));
    }
    return list;
  }

  image() {
    if (user.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: "https://i.imgur.com/BoN9kdC.png", // user.imageUrl
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white,
                  width: 4
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
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 4
            ),
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/default-profile.png")
            )
        ),
      );
    }
  }

  newStatusDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Nuevo estado",
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),
          ),
          content: TextField(
              controller: newStatusController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                "Guardar",
                style: TextStyle(
                  color: Colors.purple
                ),
              ),
              onPressed: () async {
                var newUser = await ProfileService.updateProfile(
                  user.id,
                  <String, String> {
                    "status": newStatusController.text,
                  }
                );
                setState(() {
                  user = newUser;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  newBioDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Nueva bio",
              style: TextStyle(
                  fontWeight: FontWeight.w700
              ),
            ),
            content: TextField(
              controller: newBioController
              ,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text(
                  "Guardar",
                  style: TextStyle(
                      color: Colors.purple
                  ),
                ),
                onPressed: () async {
                  print(newBioController.text);
                  var newUser = await ProfileService.updateProfile(
                      user.id,
                      <String, String> {
                        "bio": newBioController.text
                      }
                  );
                  setState(() {
                    user = newUser;
                  });
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }
  contact() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contacto:",
            style: TextStyle(
                fontWeight: FontWeight.w700
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10),),
          Text(user.email)
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.1);
    path.quadraticBezierTo(
        size.width/2, size.height/4, size.width, size.height*0.1);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}