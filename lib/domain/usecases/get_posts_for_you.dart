import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/core/usecases/usecase.dart';
import 'package:colco_poc/domain/entities/post.dart';
import 'package:colco_poc/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostsForYouUsecase implements Usecase<List<PostEntity>, int> {
  final IPostRepository _postRepository;
  GetPostsForYouUsecase(this._postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call({required int param}) async {
    return _postRepository.getForYouPosts(param);
  }
}
