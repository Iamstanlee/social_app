import 'package:colco_poc/core/failure/failure.dart';
import 'package:colco_poc/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}
