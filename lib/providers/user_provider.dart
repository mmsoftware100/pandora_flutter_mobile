
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/error/failures.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/user_login.dart';

class UserProvider extends ChangeNotifier{

  //use case list
  final UserLogin userLogin;

  //constructor
  UserProvider({
    required this.userLogin

  });

  // data repo
  User user = User.sample;

  //methods

  Future<bool> login({required String accessToken}) async {
    bool status = true;

    final Either<Failure, User> userEither = await userLogin(UserLoginParams(accessToken: accessToken));
    return userEither.fold(
            (failure) {
              print("UserProvider->login failure");
              print(failure);
              status = false;
              return status;
            },
            (loggedInUser) {
              user = loggedInUser;
              status =  true;
              return status;
            });
  }
  
}