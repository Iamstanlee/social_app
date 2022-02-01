import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/core/usecases/usecase.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePostUsecase implements Usecase<PostEntity, PostEntity> {
  final IPostRepository _postRepository;
  CreatePostUsecase(this._postRepository);

  @override
  Future<Either<Failure, PostEntity>> call({required PostEntity param}) async {
    return _postRepository.createPost(param);
  }
}
