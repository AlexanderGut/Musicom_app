import 'dart:convert';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/services/backend_connection.dart';

class PostService {


  static Future<List<Post>> fetchPosts() async {
    var conn = BackendService.getInstance();
    List<Post> posts;
    var response = await conn.get('/post');
    if (response.statusCode == 200) {
      posts = Post.listFromJson(jsonDecode(response.body));
    }
    
    return posts;
  }

  static Future<Post> fetchPost(String postId) async {
    var conn = BackendService.getInstance();
    Post post;
    var response = await conn.get('/post/$postId');
    if (response.statusCode == 200) {
      post = Post.fromJson(jsonDecode(response.body));
    }
    return post;
  }

  static Future<Post> newPost(Post post) async {
    var conn = BackendService.getInstance();
    Post post;
    var response = await conn.post(
        '/posts',
        <String, String> {
          "title": post.title,
          "type": post.type,
          "content": post.content,
          "profile_id": User.getInstance().profileId
        }
    );
    if (response.statusCode == 200) {
      post = Post.fromJson(jsonDecode(response.body));
    }
    return post;
  }

  static Future<String> updatePost(Post post) async {
    var conn = BackendService.getInstance();
    var response = await conn.put(
        '/post/${post.id}',
        <String, String> {
          "title": post.title,
          "type": post.type,
          "content": post.content
        }
    );
    if (response.statusCode == 200) {
      return "El anuncio se ha modificado exitosamente";
    }
    return "No se ha podido publicar el anuncio";
  }

  static Future<String> deletePost(String id) async {
    var conn = BackendService.getInstance();
    var response = await conn.delete('/post/$id');
    if (response.statusCode == 200) {
      return "el anuncio se ha eliminado exitosamente";
    }
    return "No se ha podido eliminar el anuncio";
  }
}