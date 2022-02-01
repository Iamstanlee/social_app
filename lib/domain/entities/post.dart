import 'package:flutter/foundation.dart';

import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/entities/user.dart';

class PostEntity {
  final UserEntity user;
  final List<CommentEntity> comments;
  final String postId;
  final String content;
  final String postedAt;
  final String? imgUrl;
  final PostEntity? sharedPost;
  final int likeCount;
  final int commentCount;
  final bool liked;

  PostEntity({
    required this.user,
    required this.comments,
    required this.postId,
    required this.content,
    required this.postedAt,
    required this.imgUrl,
    required this.sharedPost,
    required this.likeCount,
    required this.commentCount,
    required this.liked,
  });

  @override
  String toString() {
    return 'PostEntity(user: $user, comments: $comments, postId: $postId, content: $content, postedAt: $postedAt, imgUrl: $imgUrl, sharedPost: $sharedPost, likeCount: $likeCount, commentCount: $commentCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostEntity &&
      other.user == user &&
      listEquals(other.comments, comments) &&
      other.postId == postId &&
      other.content == content &&
      other.postedAt == postedAt &&
      other.imgUrl == imgUrl &&
      other.sharedPost == sharedPost &&
      other.likeCount == likeCount &&
      other.commentCount == commentCount &&
      other.liked == liked;
  }

  @override
  int get hashCode {
    return user.hashCode ^
      comments.hashCode ^
      postId.hashCode ^
      content.hashCode ^
      postedAt.hashCode ^
      imgUrl.hashCode ^
      sharedPost.hashCode ^
      likeCount.hashCode ^
      commentCount.hashCode ^
      liked.hashCode;
  }

  PostEntity copyWith({
    UserEntity? user,
    List<CommentEntity>? comments,
    String? postId,
    String? content,
    String? postedAt,
    String? imgUrl,
    PostEntity? sharedPost,
    int? likeCount,
    int? commentCount,
    bool? liked,
  }) {
    return PostEntity(
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
