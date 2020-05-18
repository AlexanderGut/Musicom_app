import 'package:musicomapp/models/profile.dart';

class Comment {
  final UserProfile user;
  final String comment;
  final String dateTime;
  final List<SubComment> subComments;

  Comment({this.user, this.comment, this.dateTime, this.subComments});

  factory Comment.fromJson(Map<String, dynamic> comment) {
    return Comment(
      user: UserProfile.fromJson(comment['user']),
      comment: comment['comment'],
      dateTime: comment['dateTime'],
      subComments: SubComment.listFromJson(comment['subComments'])
    );
  }

  static List<Comment> listFromJson(List<Map<String, dynamic>> commentList) {
    return commentList.map((c) => Comment.fromJson(c));
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
      dateTime: comment['dateTime']
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
