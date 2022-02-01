import 'package:colco_poc/data/datasources/posts_datasource/posts_local_datasource.dart';
import 'package:colco_poc/data/mappers/comment_mapper.dart';
import 'package:colco_poc/data/mappers/post_mapper.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

final entityToModel = PostEntityToModelMapper();
final modelToEntity = PostModelToEntityMapper();
final commentEntityToModel = CommentEntityToModelMapper();

class PostRepository implements IPostRepository {
  final IPostLocalDataSource _postLocalDataSource;
  PostRepository({
    required IPostLocalDataSource postLocalDataSource,
  }) : _postLocalDataSource = postLocalDataSource;

  @override
  Future<Either<Failure, List<PostEntity>>> getForYouPosts(
      int pageOffset) async {
    try {
      final _posts =
          await _postLocalDataSource.getPostsForYou(pageOffset: pageOffset);
      return Right(_posts.map((e) => modelToEntity(e)).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    try {
      final _post = await _postLocalDataSource.createPost(entityToModel(post));
      return Right(modelToEntity(_post));
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> likePost(String postId) async {
    try {
      _postLocalDataSource.likePost(postId);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> dislikePost(String postId) async {
    try {
      _postLocalDataSource.dislikePost(postId);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> makeCommentOnPost(
      String postId, CommentEntity comment) async {
    try {
      _postLocalDataSource.makeCommentOnPost(
          postId, commentEntityToModel(comment));
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
