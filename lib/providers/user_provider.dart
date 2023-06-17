
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/error/failures.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/login_with_email.dart';
import '../domain/usecases/user_login.dart';

class UserProvider extends ChangeNotifier{

  //use case list
  final UserLogin userLogin;
  final LoginWithEmail loginWithEmail;

  //constructor
  UserProvider({
    required this.userLogin,
    required this.loginWithEmail

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

  Future<bool> loginWithEmailPlz({required String email, required String password}) async {
    final Either<Failure,User> userEither = await loginWithEmail(LoginWithEmailParams(email:email,password: password));
    return userEither.fold(
            (failure) {
              print("UserProvider->loginWithEmailPlz failure");
              print(failure);
              return false;
              },
            (loggedInUser)async{
              user = loggedInUser;
              notifyListeners();
              return true;
            });
  }
  
}