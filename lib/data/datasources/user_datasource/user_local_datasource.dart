import 'package:colco_poc/core/failure/exceptions.dart';
import 'package:colco_poc/data/models/user.dart';
import 'package:hive/hive.dart';

abstract class IUserLocalDataSource {
  UserModel? getUser();
  void setUser(UserModel user);
}

class UserLocalDataSource implements IUserLocalDataSource {
  final Box _box;
  final _key = "user.db";
  UserLocalDataSource(this._box);

  @override
  UserModel? getUser() {
    try {
      return _box.get(_key);
    } catch (e) {
      CacheException();
    }
  }

  @override
  void setUser(UserModel user) {
    try {
      _box.put(_key, user);
    } catch (e) {
      CacheException();
    }
  }
}
