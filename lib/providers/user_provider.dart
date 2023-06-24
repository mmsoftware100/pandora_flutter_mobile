
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/error/failures.dart';
import '../data/constant/const.dart';
import '../domain/entities/user.dart';
import '../domain/usecases/login_with_email.dart';
import '../domain/usecases/user_login.dart';

import 'package:http/http.dart' as http;


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

  Future<bool> myLogin(String email, String password) async {
    bool status = true;

    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;


    try{
      http.Response r = await http.post(Uri.parse(loginEndpoint),headers: {"Content-Type": "application/json"},body:map );
      var data = r.body;

    }
    catch(exp){

    }
    return status;

  }
}