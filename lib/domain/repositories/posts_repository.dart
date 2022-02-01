import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<PostEntity>>> getForYouPosts(int pageOffset);
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
  Future<Either<Failure, bool>> likePost(String postId);
  Future<Either<Failure, bool>> dislikePost(String postId);
  Future<Either<Failure, bool>> makeCommentOnPost(
      String postId, CommentEntity comment);
}
