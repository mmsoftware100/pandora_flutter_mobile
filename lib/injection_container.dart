

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pandora_flutter_mobile/providers/user_provider.dart';

import 'data/datasources/network_interface.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/login_with_email.dart';
import 'domain/usecases/user_login.dart';

final sl = GetIt.instance;


Future<void> init() async {


  /* Factory ဆိုတာက App တစ်ခုလုံးမှာမှ တစ်ခုပဲ ရှိမယ့် ဟာမျိုးကို ဆိုလိုတာလား မသိ */
  /*
  /// Providers
  sl.registerFactory(
          () => UserProvider(
        userLogin: sl(),
        loginWithEmail: sl(),
      )
  );

   */

  /// Use Cases
  sl.registerLazySingleton<UserLogin>(() =>  UserLogin(userRepository: sl()));
  sl.registerLazySingleton<LoginWithEmail>(() =>  LoginWithEmail(userRepository: sl()));

  /// Repositories
  // sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(userRemoteDataSource: sl()));

  // Data Sources

  // Network
  sl.registerLazySingleton<NetworkInterface>(() => NetworkInterfaceImpl(client: sl()));


  sl.registerLazySingleton(() => Dio());

  ///
}

