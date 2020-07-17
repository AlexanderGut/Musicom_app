import 'package:flutter/material.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/screens/widgets/post_card.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';

class PostsScreen extends StatefulWidget {

  @override
  _PostsScreen createState() => _PostsScreen();
}

class _PostsScreen extends State<PostsScreen> {

  List filters = ["Venta", "Compra", "Instrumentos", "Busco", "Músico"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _header(),
            _body()
          ],
        ),
      ),
    );
  }

  _header() {
    return Container(
      color: Colors.grey.withAlpha(60),
      padding: EdgeInsets.only(top: 40, left: 5),
      height: 80,
      child: Row(
        children: <Widget>[
          Text("Filtros"),
          Container(
            height: 24,
            width: MediaQuery.of(context).size.width*0.8,
            margin: EdgeInsets.only(top: 2, bottom: 2, left: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [],
            ),
          )
        ],
      ),
    );
  }

  _body() {
    Post post = Post(
      title: "Post de prueba con titulo largo, con el fin de ver que cuantas lineas puede mostrar esta card",
      tags: ["Venta", "Guitarra", "Musico", "Compra"]
    );
    return Container(
      height: MediaQuery.of(context).size.height-80,
      child: ListView(
        children: <Widget>[
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),
          PostCard(post),

        ],
      ),
    );
  }

  _filterTags() {
    List<Widget> tags = List();
    for (var t in filters) {
      tags.add(
          TagButton(
            tag: t,
            pressed: false,
            onPressed: () async {
              if (filters.contains(t)) {
                filters.remove(t);
              } else {
                filters.add(t);
              }
            },
          )
      );
    }
    return tags;
  }
}