import 'package:colco_poc/core/utils/view_state.dart';
import 'package:colco_poc/domain/entities/user.dart';
import 'package:colco_poc/domain/usecases/get_user_usecase.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final GetUserUsecase _getUserUsecase;
  UserProvider({required GetUserUsecase getUserUsecase})
      : _getUserUsecase = getUserUsecase;

  DataState<UserEntity> _userData = DataState.loading();
  DataState<UserEntity> get userData => _userData;
  set userData(DataState<UserEntity> value) {
    _userData = value;
    notifyListeners();
  }

  void getUser() async {
    final failureOrUser = await _getUserUsecase();
    failureOrUser.fold(
      (failure) => userData = DataState.error("An unexpected error occured"),
      (user) => userData = DataState.done(user),
    );
  }
}
