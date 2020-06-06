import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/services/profile_service.dart';


class ProfileScreen extends StatefulWidget {
  final String profileId;

  ProfileScreen({Key key, @required this.profileId}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  Profile user;
  String profileId;
  bool _load = false;
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
                if (!_load) {
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
                      divider()
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
              user.status != null ? user.status : "",
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