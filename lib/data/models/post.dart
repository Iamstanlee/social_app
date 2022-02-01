import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:colco_poc/data/models/comment.dart';
import 'package:colco_poc/data/models/user.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class PostModel extends HiveObject {
  @HiveField(0)
  final UserModel user;

  @HiveField(1)
  List<CommentModel> comments;

  @HiveField(2)
  final String postId;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final String postedAt;

  @HiveField(5)
  final String? imgUrl;

  @HiveField(6)
  final PostModel? sharedPost;

  @HiveField(7)
  int likeCount;

  @HiveField(8)
  int commentCount;
  @HiveField(9, defaultValue: false)
  final bool liked;
  PostModel({
    required this.user,
    required this.comments,
    required this.postId,
    required this.content,
    required this.postedAt,
    this.imgUrl,
    this.sharedPost,
    required this.likeCount,
    required this.commentCount,
    required this.liked,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'comments': comments.map((x) => x.toMap()).toList(),
      'postId': postId,
      'content': content,
      'postedAt': postedAt,
      'imgUrl': imgUrl,
      'sharedPost': sharedPost?.toMap(),
      'likeCount': likeCount,
      'commentCount': commentCount,
      'liked': liked,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      user: UserModel.fromMap(map['user']),
      comments: List<CommentModel>.from(
          map['comments']?.map((x) => CommentModel.fromMap(x))),
      postId: map['postId'] ?? '',
      content: map['content'] ?? '',
      postedAt: map['postedAt'] ?? '',
      imgUrl: map['imgUrl'],
      sharedPost: map['sharedPost'] != null
          ? PostModel.fromMap(map['sharedPost'])
          : null,
      likeCount: map['likeCount']?.toInt() ?? 0,
      commentCount: map['commentCount']?.toInt() ?? 0,
      liked: map['liked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  PostModel copyWith({
    UserModel? user,
    List<CommentModel>? comments,
    String? postId,
    String? content,
    String? postedAt,
    String? imgUrl,
    PostModel? sharedPost,
    int? likeCount,
    int? commentCount,
    bool? liked,
  }) {
    return PostModel(
      user: user ?? this.user,
      comments: comments ?? this.comments,
      postId: postId ?? this.postId,
      content: content ?? this.content,
      postedAt: postedAt ?? this.postedAt,
      imgUrl: imgUrl ?? this.imgUrl,
      sharedPost: sharedPost ?? this.sharedPost,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      liked: liked ?? this.liked,
    );
  }
}
