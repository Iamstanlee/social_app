import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:colco_poc/data/models/user.dart';

part 'comment.g.dart';

@HiveType(typeId: 2)
class CommentModel {
  @HiveField(0)
  final UserModel user;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String postedAt;
  CommentModel({
    required this.user,
    required this.content,
    required this.postedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'content': content,
      'postedAt': postedAt,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      user: UserModel.fromMap(map['user']),
      content: map['content'] ?? '',
      postedAt: map['postedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));
}
