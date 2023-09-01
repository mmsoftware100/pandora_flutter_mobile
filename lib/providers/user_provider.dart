
import 'dart:convert';
import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/error/failures.dart';
import '../data/constant/const.dart';
import '../domain/entities/user.dart';
import '../domain/entities/user_statistics.dart';
import '../domain/usecases/login_with_email.dart';
import '../domain/usecases/user_login.dart';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';
import '../model/user_statistics_model.dart';
import '../utils/api_services.dart';

/*

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

 */

class UserProvider extends ChangeNotifier{

  UserModel user = UserModel(id: 0, uid: '', name: '', phone: '', city: '', age: '', gender: '', photoUrl: '', email: '', emailVerifiedAt: '', roleId: 0, createdAt: '', updatedAt: '', accessToken: '', userStatistics: []);
  bool registrationStatus = false;


  Future<bool> registration(String name,String email,String password) async{
    bool status = false;

    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;

    try{
      await ApiServices.registration(map).then((value) {
        Map<String,dynamic> dataResponse = jsonDecode(value);
        print(dataResponse);
        print(dataResponse['status']);
        registrationStatus = dataResponse['status'];
        notifyListeners();
      });
      status = true;
    }catch (Exc) {
      print(Exc);
      status = false;
    }
    return status;
  }

  Future<bool> login({required String email,required String password}) async{
    bool status = false;

    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;

    // var requestBody = {
    //   'email': email,
    //   'password': password
    // };

    try{
      await ApiServices.login(map).then((value) {
        Map<String,dynamic> dataResponse = jsonDecode(value);
        print(dataResponse);
        user = UserModel.fromJson(dataResponse['data']);
        print("Hey");
        print(user.accessToken);
        notifyListeners();
      });
      status = true;
    }catch (Exc) {
      print(Exc);
      status = false;
    }
    return status;
  }
}