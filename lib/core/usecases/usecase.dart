import 'package:colco_poc/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<R, P> {
  Future<Either<Failure, R>> call({required P param});
}

class NoParam {}
