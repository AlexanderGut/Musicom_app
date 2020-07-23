import 'dart:convert';
import 'package:http/http.dart';
import 'package:musicomapp/models/comment.dart';
import 'package:musicomapp/models/post.dart';
import 'package:musicomapp/models/user.dart';
import 'package:musicomapp/services/backend_connection.dart';

class PostService {


  static Future<List<Post>> fetchPosts(List<String> filters) async {
    var conn = BackendService.getInstance();
    List<Post> posts;
    var response = await conn.post(
      '/posts',
      <String, dynamic>{
        'filters': filters
    });
    if (response.statusCode == 200) {
      var pBody = jsonDecode(response.body);
      print(pBody);
      posts = Post.listFromJson(pBody["posts"]);
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
    Post rPost;
    var response = await conn.post(
        '/post/null',
        <String, dynamic> {
          "title": post.title,
          "content": post.content,
          "tags": post.tags,
          "user": <String, String> {
            "profile_id": post.userProfile.profileId,
            "name": post.userProfile.name,
            "img_url": post.userProfile.imageUrl
          },
          "comments": List()
        }
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      rPost = Post.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
    return rPost;
  }

  static Future<Post> updatePost(Post post) async {
    var conn = BackendService.getInstance();
    print(post.comments);
    var response = await conn.put(
        '/post/${post.id}',
        <String, dynamic> {
          "comments": Comment.listToJson(post.comments)
        }
    );
    print(jsonDecode(response.body));
    return Post.fromJson(jsonDecode(response.body));
  }

  static Future<Response> deletePost(String id) async {
    var conn = BackendService.getInstance();
    var response = await conn.delete('/post/$id');
    return response;
  }
}