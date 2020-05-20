import 'package:musicomapp/models/comment.dart';
import 'package:musicomapp/models/profile.dart';


class Post {

  final String id;
  final String title;
  final String content;
  final String type;
  final String date;
  final String updateDate;
  final Profile userProfile;
  final List<Comment> comments;

  Post({
    this.id,
    this.title,
    this.content,
    this.type,
    this.date,
    this.updateDate,
    this.userProfile,
    this.comments
  });

  factory Post.fromJson(Map<String, dynamic> post) {

    Post p = Post(
      id: post['id'],
      title: post['title'],
      content: post['content'],
      type: post['type'],
      date: post['date'],
      updateDate: post['update_date'],
      userProfile: Profile.fromJson(post['user']),
      comments: Comment.listFromJson(post['comments'])
    );

    return p;
  }

  static List<Post> listFromJson(List<Map<String, dynamic>> postList) {
    return postList.map((p) => Post.fromJson(p));
  }

}