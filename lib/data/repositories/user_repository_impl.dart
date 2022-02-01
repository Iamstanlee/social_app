import 'package:colco_poc/core/failure/exceptions.dart';
import 'package:colco_poc/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:colco_poc/data/mappers/user_mapper.dart';
import 'package:colco_poc/domain/entities/user.dart';
import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepository implements IUserRepository {
  final IUserLocalDataSource _localDataSource;
  UserRepository(this._localDataSource);

  final UserEntity _user = UserEntity(
    username: 'Colco_App',
    userId: 'fooBar',
    bio: 'Audio-centric Social Network for Professionals & Startups',
  );

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final user = _localDataSource.getUser();
      final modelToEntity = UserModelToEntityMapper();
      if (user != null) {
        return Right(modelToEntity(user));
      }
      final entityToModel = UserEntityToModelMapper();
      _localDataSource.setUser(entityToModel(_user));
      return Right(_user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
