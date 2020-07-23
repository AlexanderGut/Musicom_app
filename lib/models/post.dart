import 'package:musicomapp/models/comment.dart';
import 'package:musicomapp/models/profile.dart';


class Post {

  final String id;
  final String title;
  final String content;
  final String type;
  final String date;
  final String updateDate;
  final UserProfile userProfile;
  final List<String> tags;
  final List<Comment> comments;

  Post({
    this.id,
    this.title,
    this.content,
    this.type,
    this.date,
    this.updateDate,
    this.userProfile,
    this.tags,
    this.comments
  });

  factory Post.fromJson(Map<String, dynamic> post) {
    List<String> tags = List();
    for(var t in post["tags"]) {
      tags.add(t.toString());
    }
    Post p = Post(
      id: post['id'],
      title: post['title'],
      content: post['content'],
      type: post['post_type'],
      date: post['create_at'],
      updateDate: post['update_at'],
      userProfile: UserProfile.fromJson(post['user']),
      tags: tags,
      comments: Comment.listFromJson(post['comments'])
    );

    return p;
  }

  static List<Post> listFromJson(List<dynamic> postList) {
    return postList.map((p) => Post.fromJson(p)).toList();
  }

}