import 'package:flutter/material.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/screens/new_post_screen.dart';
import 'package:musicomapp/screens/widgets/post_card.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/services/post_service.dart';

class PostsScreen extends StatefulWidget {

  @override
  _PostsScreen createState() => _PostsScreen();
}

class _PostsScreen extends State<PostsScreen> {

  List filtersOptions = ["Venta", "Compra", "Anuncio", "Intrumento",
    "Busco", "Ofrezco"];
  List<String> filters = List();
  List<Post> posts = new List();

  @override
  void initState() {
    filters.clear();
    PostService.fetchPosts(filters).then((value) {
      posts.clear();
      setState(() {
        posts.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPostScreen())
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
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
              children: _filterTags(),
            ),
          )
        ],
      ),
    );
  }

  _body() {
    return Container(
      height: MediaQuery.of(context).size.height-80,
      child: ListView(
        children: postsWidgets(),
      ),
    );
  }

  _filterTags() {
    List<Widget> tags = List();
    for (var t in filtersOptions) {
      tags.add(
        TagButton(
          tag: t,
          pressed: false,
          onPressed: () {
            if (filters.contains(t)) {
              filters.remove(t);
              PostService.fetchPosts(filters).then((value) {
                posts.clear();
                setState(() {
                  posts.addAll(value);
                });
              });
            } else {
              filters.add(t);
              PostService.fetchPosts(filters).then((value) {
                posts.clear();
                setState(() {
                  posts.addAll(value);
                });
              });
            }
          },
        )
      );
    }
    return tags;
  }

  postsWidgets() {
    List<Widget> pos = List();
    for(var p in posts) {
      pos.add(PostCard(p));
    }
    return pos;
  }
}