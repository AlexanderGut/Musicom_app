import 'package:http/http.dart';
import 'package:musicomapp/models/comment.dart';
import 'package:musicomapp/services/backend_connection.dart';

class CommentService {

  static newComment(String type, String id, String comment) async {
    var conn = BackendService.getInstance();
    var response = await conn.post(
        '/comment',
        <String, String>{
          'type': type,
          'id': id,
          'comment': comment
        }
    );
  }

  static updateComment(String type, String id, Comment comment) async {
    var conn = BackendService.getInstance();
    var response = await conn.put(
        '/comment',
        <String, String>{
          'type': type,
          'id': id,
          'comment': comment.comment
        }
    );
  }
}