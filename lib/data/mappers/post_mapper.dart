import 'package:colco_poc/data/mappers/comment_mapper.dart';
import 'package:colco_poc/data/mappers/user_mapper.dart';
import 'package:colco_poc/data/models/comment.dart';
import 'package:colco_poc/data/models/post.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/entities/post.dart';

class PostEntityToModelMapper {
  PostModel call(PostEntity post) {
    final entityToModel = UserEntityToModelMapper();
    final commentEntityToModel = CommentEntityToModelMapper();
    final List<CommentModel> _comments =
        post.comments.map((e) => commentEntityToModel(e)).toList();
    final sharedPostEntityToModel = PostEntityToModelMapper();

    return PostModel(
      user: entityToModel(post.user),
      comments: _comments,
      commentCount: post.commentCount,
      postId: post.postId,
      content: post.content,
      postedAt: post.postedAt,
      imgUrl: post.imgUrl,
      sharedPost: post.sharedPost != null
          ? sharedPostEntityToModel(post.sharedPost!)
          : null,
      likeCount: post.likeCount,
      liked: post.liked,
    );
  }
}

class PostModelToEntityMapper {
  PostEntity call(PostModel post) {
    final modelToEntity = UserModelToEntityMapper();
    final commentModelToEntity = CommentModelToEntityMapper();
    final List<CommentEntity> _comments =
        post.comments.map((e) => commentModelToEntity(e)).toList();
    final sharedPostModelToEntity = PostModelToEntityMapper();
    return PostEntity(
      user: modelToEntity(post.user),
      comments: _comments,
      commentCount: post.commentCount,
      postId: post.postId,
      content: post.content,
      postedAt: post.postedAt,
      imgUrl: post.imgUrl,
      sharedPost: post.sharedPost != null
          ? sharedPostModelToEntity(post.sharedPost!)
          : null,
      likeCount: post.likeCount,
      liked: post.liked,
    );
  }
}
