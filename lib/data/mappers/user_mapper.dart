import 'package:colco_poc/data/models/user.dart';
import 'package:colco_poc/domain/entities/user.dart';

class UserEntityToModelMapper {
  UserModel call(UserEntity user) {
    return UserModel(
      userId: user.userId,
      username: user.username,
      bio: user.bio,
    );
  }
}

class UserModelToEntityMapper {
  UserEntity call(UserModel user) {
    return UserEntity(
      userId: user.userId,
      username: user.username,
      bio: user.bio,
    );
  }
}
