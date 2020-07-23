import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/widgets/tag_button.dart';
import 'package:musicomapp/screens/widgets/user_card.dart';
import 'package:musicomapp/services/profile_service.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreen createState() => _UserListScreen();
}

class _UserListScreen extends State {
  static int page = 0;
  static List<String> filters = List();
  List _styles = [
    "Bachata", "Baladas", "Blues", "Bolero", "Bosa Nova", "Celta", "Clásica",
    "Corrido", "Country", "Criollo", "Cumbia", "Disco", "Dubstep", "Electrónica",
    "Flamenco", "Folk", "Funk", "Garage Rock", "Gospel", "Heavy Metal", "Hip Hop",
    "Indie", "Jazz", "Merengue", "Polka", "Pop", "Punk", "Ranchera", "Rap", "Reggae",
    "Reggaeton", "Rumba", "Rhythm and Blues", "Rock", "Rock and Roll", "Salsa",
    "Samba", "Ska", "Son", "Soul", "Swing", "Tango", "Trap", "Trova", "Vals", "Vallenato"
  ];
  ScrollController sc = ScrollController();
  bool loading = false;
  List<UserProfile> users = new List();

  @override
  void initState() {
    filters.clear();
    ProfileService.fetchUserProfiles(
      filters: <String, dynamic>{
        'profile_id': User.getInstance().profileId,
        'filters': filters
      }
    ).then((value) {
      setState(() {
        users.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Column(
          children: <Widget>[
            _header(),
            _body()
          ],
        ),
      )
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
            width: 305,
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
      height: MediaQuery.of(context).size.height - 80,
      child: _buildList(),
    );
  }
  @override
  void dispose() {
    sc.dispose();
    super.dispose();
  }

  _getUsers(int index) async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      var _users = await ProfileService.fetchUserProfiles();
      setState(() {
        loading = false;
        users.addAll(_users);
        page++;
      });
    }
  }

  _buildList() {
    return ListView.builder(
      itemCount: users.length + 1,
      itemBuilder: (context, index) {
        if (users.length > 0) {
          if (index == users.length) {
            return Container();
          } else {
            return UserCard(users[index]);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      controller: sc,
    );
  }

  _appBar() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar()
      ],
    );
  }

  _filterTags() {
    List<Widget> tags = List();
    for (var t in _styles) {
      tags.add(
        TagButton(
          tag: t,
          pressed: false,
          onPressed: () async {
            if (filters.contains(t)) {
              setState(() {
                filters.remove(t);
                ProfileService.fetchUserProfiles(
                    filters: <String, dynamic>{
                      'profile_id': User.getInstance().profileId,
                      'filters': filters
                    }
                ).then((value) {
                  setState(() {
                    users.clear();
                    users.addAll(value);
                  });
                });
              });
            } else {
              setState(() {
                filters.add(t);
                ProfileService.fetchUserProfiles(
                    filters: <String, dynamic>{
                      'profile_id': User.getInstance().profileId,
                      'filters': filters
                    }
                ).then((value) {
                  setState(() {
                    users.clear();
                    users.addAll(value);
                  });
                });
              });
            }
            print(filters);
          },
        )
      );
    }
    return tags;
  }
}

//CustomScrollView(
//slivers: <Widget>[
//SliverAppBar(
//centerTitle: false,
//pinned: true,
//backgroundColor: Colors.white,
//expandedHeight: 50,
//title: Container(
//child: Text(
//"Filtros",
//style: TextStyle(
//color: Colors.black
//),
//),
//),
//flexibleSpace: FlexibleSpaceBar(
//centerTitle: false,
//title: Container(
//color: Colors.white,
//margin: EdgeInsets.only(left: 10),
//height: 20,
//child: ListView(
//scrollDirection: Axis.horizontal,
//children: _filterTags(),
//),
//),
//),
//)
//],
//
//)