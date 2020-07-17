import 'dart:convert';
import 'package:http/http.dart';
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
        <String, dynamic> {
          "title": post.title,
          "content": post.content,
          "tags": post.tags,
          "user": <String, String> {
            "profile_id": post.userProfile.profileId,
            "name": post.userProfile.name,
            "img_url": post.userProfile.imageUrl
          }
        }
    );
    if (response.statusCode == 200) {
      post = Post.fromJson(jsonDecode(response.body));
    }
    return post;
  }

  static Future<Response> updatePost(Post post) async {
    var conn = BackendService.getInstance();
    var response = await conn.put(
        '/post/${post.id}',
        <String, String> {
          "title": post.title,
          "type": post.type,
          "content": post.content
        }
    );
    return response;
  }

  static Future<Response> deletePost(String id) async {
    var conn = BackendService.getInstance();
    var response = await conn.delete('/post/$id');
    return response;
  }
}