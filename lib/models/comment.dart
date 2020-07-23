import 'package:musicomapp/models/profile.dart';

class Comment {
  final UserProfile user;
  final String comment;
  final bool subComment;
  final String dateTime;
  final List<Comment> subComments;

  Comment({this.user, this.comment, this.subComment, this.dateTime, this.subComments});

  factory Comment.fromJson(Map<String, dynamic> comment) {
    return Comment(
      user: UserProfile(
        profileId: comment["user"]["profile_id"],
        imageUrl: comment["user"]["img_url"],
        name: comment["user"]["name"]
      ),
      comment: comment['comment'],
      dateTime: comment['create_at'],
      subComments: Comment.listFromJson(comment['comments'])
    );
  }

  static List<Comment> listFromJson(List<dynamic> commentList) {
    List<Comment> list = List();
    if (commentList != null) {
      for (var i in commentList) {
        list.add(Comment.fromJson(i));
      }
      return list;
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>> listToJson(List<Comment> comments) {
    List<Map<String, dynamic>> commentsList = List();
    for(var c in comments) {
      List<Map<String, dynamic>> sub = List();
//      if(c.subComment) {
//        sub.addAll(Comment.listToJson(c.subComments));
//      }
      commentsList.add(
        <String, dynamic> {
          "comment": c.comment,
          "sub_comment": c.subComment,
          "user": <String, String> {
            "profile_id": c.user.profileId,
            "name": c.user.name,
            "img_url": c.user.imageUrl
          },
          "comments": sub
        }
      );
    }
    return commentsList;
  }
}

class SubComment {
  final UserProfile user;
  final String comment;
  final String dateTime;

  SubComment({this.user, this.comment, this.dateTime});

  factory SubComment.fromJson(Map<String, dynamic> comment) {
    return SubComment(
      user: UserProfile.fromJson(comment['user']),
      comment: comment['comment'],
      dateTime: comment['date_time']
    );
  }

  static List<SubComment> listFromJson(List<Map<String, dynamic>> commentList) {
    return commentList.map((c) => SubComment.fromJson(c));
  }
}


// el siguiente modelo es para considerar a futuro
// necesita que los comentarios estén en un documento
// lo que permite mayor funcionalidad en los comentarios
// sin embargo, resulta mas compĺejo
/*
abstract class BaseComment {

  final String id;
  final UserProfile user;
  final String comment;
  final String dateTime;

  BaseComment(this.id, this.user, this.comment, this.dateTime);

}

class PostComment extends BaseComment {

  final postId;

 PostComment(
     String id,
     UserProfile user,
     String comment,
     String dateTime,
     this.postId
     ) : super(id, user, comment, dateTime);

 factory PostComment.formJson(Map<String, dynamic> comment) {
   return PostComment(
     comment['id'],
     UserProfile.fromJson(comment['user']),
     comment['comment'],
     comment['dateTime'],
     comment['postId']
   );
 }

  static List<PostComment> listFromJson(List<Map<String, dynamic>> commentList){
    return commentList.map((c) => PostComment.formJson(c));
  }
}

class ProfileComment extends BaseComment {

  final int profileId;

  ProfileComment(
      String id,
      UserProfile user,
      String comment,
      String dateTime,
      this.profileId
      ) : super(id, user, comment, dateTime);
  
  factory ProfileComment.fromJson(Map<String, dynamic> comment) {
    
    return ProfileComment(
      comment['id'],
      UserProfile.fromJson(comment['user']),
      comment['comment'],
      comment['dateTime'],
      comment['profileId']
    );
  }

  static List<ProfileComment> listFromJson(List<Map<String, dynamic>> commentList){
    return commentList.map((c) => ProfileComment.fromJson(c)).toList();
  }
}

class ResponseComment extends BaseComment {
  final int idComment;

  ResponseComment(
      String id,
      UserProfile user,
      String comment,
      String dateTime,
      this.idComment
      ) : super(id, user, comment, dateTime);

  factory ResponseComment.fromJson(Map<String, dynamic> comment) {

    return ResponseComment(
        comment['id'],
        UserProfile.fromJson(comment['user']),
        comment['comment'],
        comment['dateTime'],
        comment['profileId']
    );
  }

  static List<ProfileComment> listFromJson(List<Map<String, dynamic>> commentList){
    return commentList.map((c) => ProfileComment.fromJson(c)).toList();
  }
}*/
