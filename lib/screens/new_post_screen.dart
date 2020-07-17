import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/services/post_service.dart';

class NewPostScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _NewPostScreen();
}

class _NewPostScreen extends State<NewPostScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  var tags = List();
  List optionTags = ["Venta", "Compra", "Anuncio", "Intrumento",
    "Busco", "Ofrezco"
  ];
  static List<TagButton> tl = List();
  @override
  void initState() {
    super.initState();
    initOptions();
  }

  _NewPostScreen() {
    titleController.addListener(titleListener);
    contentController.addListener(contentListener);
  }


  titleListener() {

  }

  contentListener() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Título:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Título"
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Contenido:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: contentController,
                maxLines: 10,
                maxLength: 255,
                style: TextStyle(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Etiquetas:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Wrap(
                children: tl,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 40,
                  right: 40),
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                color: Colors.purple,
                textColor: Colors.white,
                child: Text("Publicar"),
                onPressed: () async {
                  User user = User.getInstance();
                  Post post = Post(
                    title: titleController.text,
                    content: contentController.text,
                    tags: tags,
                    userProfile: UserProfile(
                      profileId: user.profileId,
                      name: "${user.name} ${user.lastName}",
                      imageUrl: user.imgUrl
                    )
                  );
                  PostService.newPost(post);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  initOptions() {
    for(var t in optionTags) {
      tl.add(
          TagButton(
            tag: t,
            pressed: false,
            onPressed: () {
              if (!tags.contains(t)) {
                tags.add(t);
              } else {
                tags.remove(t);
              }
            },
          )
      );
    }
  }

}