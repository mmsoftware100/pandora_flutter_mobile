

import 'package:pandora_flutter_mobile/data/datasources/network_interface.dart';

import '../../domain/entities/user.dart';
import '../../model/user_model.dart';
import '../constant/const.dart';

abstract class UserRemoteDataSource{
  Future<User> login({required String accessToken});


  Future<User> loginWithEmail({
    required String email,
    required String password,
  });

  Future<User> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String city,
    required String age,
    required String gender
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{
  final NetworkInterface networkInterface;
  UserRemoteDataSourceImpl({required this.networkInterface});

  @override
  Future<User> login({required String accessToken}) async{

    var data = {
      "access_token" : accessToken,
    };
    dynamic response = await networkInterface.postRequest(url: loginEndpoint, data: data);
    try{
      //bool status = response['status'];
      //String message = response['msg'];
      var data = response['data'];
      UserModel userModel = UserModel.fromJson(data);
      return userModel.toEntity();
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<User> loginWithEmail({required String email, required String password}) async{
    var data = {
      "email" : email,
      "password" : password
    };
    print("UserRemoteDatasource->loginWithEmail");
    print(data);

    dynamic response = await networkInterface.postRequest(url: loginEndpoint, data: data);
    try{
      //bool status = response['status'];
      //String message = response['msg'];
      var data = response['data'];
      UserModel userModel = UserModel.fromJson(data);
      return userModel.toEntity();
    }
    catch(e){
      rethrow;
    }
  }



  @override
  Future<User> userRegister({required String name, required String email, required String password, required String phone, required String city, required String age, required String gender})  async{
    var data = {
      "name" : name,
      "email" : email,
      "password" : password,
      "phone" : phone,
      "city" : city,
      "age" : age,
      "gender" : gender
    };
    print("UserRemoteDatasource->userRegister");
    print(data);
    dynamic response = await networkInterface.postRequest(url: userRegisterEndpoint, data: data);
    try{
      var data = response['data'];
      UserModel userModel = UserModel.fromJson(data);
      return userModel.toEntity();
    }
    catch(e){
      rethrow;
    }
  }



}
