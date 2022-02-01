import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/core/usecases/usecase.dart';
import 'package:colco_poc/domain/entities/user.dart';
import 'package:colco_poc/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements Usecase<UserEntity, void> {
  final IUserRepository _userRepository;
  GetUserUsecase(this._userRepository);

  @override
  Future<Either<Failure, UserEntity>> call({void param}) async {
    return _userRepository.getUser();
  }
}
