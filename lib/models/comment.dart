

import 'package:flutter/rendering.dart';

abstract class BaseComment {

  final int id;
  final int userId;
  final String comment;
  final String dateTime;

  BaseComment(this.id, this.userId, this.comment, this.dateTime);
}

class PostComment extends BaseComment {

  final postId;

 PostComment(
     int id,
     int userId,
     String comment,
     String dateTime,
     this.postId
     ) : super(id, userId, comment, dateTime);
}

class ProfileComment extends BaseComment {

  final int profileId;

  ProfileComment(
      int id,
      int userId,
      String comment,
      String dateTime,
      this.profileId
      ) : super(id, userId, comment, dateTime);

}

class ResponseComment extends BaseComment {
  final int idComment;

  ResponseComment(
      int id,
      int userId,
      String comment,
      String dateTime,
      this.idComment
      ) : super(id, userId, comment, dateTime);
}