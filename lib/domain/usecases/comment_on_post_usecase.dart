import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/core/usecases/usecase.dart';
import 'package:colco_poc/domain/entities/comment.dart';
import 'package:colco_poc/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class CommentOnPostUsecase implements Usecase<bool, CommentParams> {
  final IPostRepository _postRepository;
  CommentOnPostUsecase(this._postRepository);

  @override
  Future<Either<Failure, bool>> call({required CommentParams param}) async {
    return _postRepository.makeCommentOnPost(param.postId, param.comment);
  }
}

class CommentParams {
  final String postId;
  final CommentEntity comment;
  CommentParams(this.postId, this.comment);
}
