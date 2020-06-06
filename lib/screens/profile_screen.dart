import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/services/profile_service.dart';


class ProfileScreen extends StatefulWidget {
  final Profile profile;

  ProfileScreen({Key key, @required this.profile}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  Profile user;

  @override
  void initState() {
    super.initState();
    user = widget.profile;
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
            child: ListView(
              children: <Widget>[
                headProfile(),
                divider(),
                bioInfo(),
                divider(),
                instrument(),
                divider(),
                styles(),
                divider(),
                media(),
                divider()
              ],
            ),
          ),
        ),
      )
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
      height: 220,
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 110,
              height: 110,
              child: CachedNetworkImage(
                imageUrl: "https://i.imgur.com/BoN9kdC.png",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: new BoxDecoration(
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
              ),
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
            padding: EdgeInsets.only(top: 10),
            child: Text(
              user.status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),
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
          Text(
            "Bio:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w700
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            "If that's not a good fit for whatever reason, you can use find.byWidgetPredicate and pass a function that matches RichText widgets whose text.toPlainText() returns the string you want",
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
            "Guitarra"
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
          Text(
            ""//stylesString(user.styles)
          )
        ],
      )
    );
  }

  stylesString(List<String> styles) {
    String str = "";
    for (var i = 0; i < styles.length;i++) {
      if (i!=styles.length-1) {
        str += "${styles[i]}, ";
      } else {
        str += styles[i];
      }
    }
    return str;
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
    // TODO: implement shouldRepaint
    return true;
  }
}