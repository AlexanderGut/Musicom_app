import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicomapp/models/comment.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/screens/widgets/comment_card.dart';
import 'package:musicomapp/services/post_service.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  PostScreen({this.post});
  _PostScreen createState() => _PostScreen();
}

class _PostScreen extends State<PostScreen> {

  Post post;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  userInfo(),
                  date(post.date),
                  title(),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  content(),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  divider(),
                  newCommentButton(context),
                  Padding(padding: EdgeInsets.only(bottom: 10),),
                ],
              ),
            ),
            Container(
              child: Flexible(
                child: ListView(
                  children: comments(),
                ),
              )
            )
          ],
        )
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

  title() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        post.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  content() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        post.content
      ),
    );
  }

  userInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10),
        child: ListTile(
          leading: Container(
            alignment: Alignment.bottomLeft,
            height: 50,
            width: 50,
            child: CachedNetworkImage(
              imageUrl: "https://i.imgur.com/BoN9kdC.png", // user.imageUrl
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2
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
          title: Text(post.userProfile.name),
          onTap: () {},
        )
    );
  }

  date(String date) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Text(date),
    );
  }

  newCommentButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
        child: MaterialButton(
          elevation: 5.0,
          child: Icon(Icons.comment, color: Colors.purple,),
          onPressed: () {
            newCommentDialog(context);
          },
        )
    );
  }

  newCommentDialog(BuildContext context) {
    var user = User.getInstance();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nuevo comentario"),
          content: TextField(
            controller: commentController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text(
                "Comentar",
                style: TextStyle(
                  color: Colors.purple
                ),
              ),
              onPressed: () async {
                Comment comment = Comment(
                  comment: commentController.text,
                  subComment: false,
                  user: UserProfile(
                    profileId: user.profileId,
                    name: "${user.name} ${user.lastName}",
                    imageUrl: user.imgUrl
                  )
                );
                print(comment.subComment);
                post.comments.add(comment);
                var newPost = await PostService.updatePost(post);
                setState(() {
                  post = newPost;
                });
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
  comments() {
    List<Widget> com = List();
    for(var c in post.comments){
      com.add(CommentCard(c));
    }
    return com;
  }
}