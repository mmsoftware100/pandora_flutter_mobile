import 'package:dio/dio.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';

abstract class NetworkInterface {
  Future<dynamic> getRequest({required String url, required Map<
      String,
      dynamic> data, String? bearerToken});

  Future<dynamic> postRequest({required String url, required Map<
      String,
      dynamic> data, String? bearerToken});

  Future<dynamic> putRequest(
      {required String url, required int id, required Map<String,
          dynamic> data, String? bearerToken});

  Future<dynamic> deleteRequest(
      {required String url, required int id, String? bearerTplem});
}

class NetworkInterfaceImpl implements NetworkInterface {
  final Dio client;
  NetworkInterfaceImpl({
    required this.client
  });

  @override
  Future<dynamic> deleteRequest({required String url, required int id, String? bearerTplem}) async{
    try{
      String endPoint = url + "/$id";
      Map<String,dynamic> data = {};
      if(bearerTplem != null){
        client.options.headers["Authorization"] = "Bearer $bearerTplem";
      }
      Response<dynamic> response = await client.delete(endPoint);
      data = response.data;
      return data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
      }
      print(exp);
      throw ServerException();
    }

  }

  @override
  Future<dynamic> getRequest({required String url, required Map<String,dynamic> data, String? bearerToken}) async{
    try{
      String endPoint = url;
      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      Response<dynamic> response = await client.get(endPoint);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
      }
      print(exp);
      throw ServerException();
    }
  }

  @override
  Future<dynamic> postRequest({required String url, required Map<
      String,
      dynamic> data, String? bearerToken}) async{
    try{
      String endPoint = url;
      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      Response<dynamic> response = await client.post(endPoint, data: data);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
      }
      print(exp);
      throw ServerException();
    }
  }

  @override
  Future<dynamic> putRequest(
      {required String url, required int id, required Map<String,
          dynamic> data, String? bearerToken}) async{
    try{
      String endPoint = url + "/$id";
      if(bearerToken != null){
        client.options.headers["Authorization"] = "Bearer $bearerToken";
      }
      Response<dynamic> response = await client.put(endPoint, data: data);
      return response.data;
    }
    catch(exp){
      if(exp is DioError){
        print("exp is DioError");
        print(exp.response);
      }
      print(exp);
      throw ServerException();
    }
  }

}
