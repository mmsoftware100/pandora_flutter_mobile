// import 'package:dartz/dartz.dart';
//
// import '../../core/error/failures.dart';
// import '../../domain/entities/user.dart';
// import '../../domain/repositories/user_repository.dart';
// import '../datasources/user_remote_datasource.dart';
//
//
// class UserRepositoryImpl implements UserRepository{
//   UserRemoteDataSource userRemoteDataSource;
//
//   UserRepositoryImpl({required this.userRemoteDataSource});
//
//
//   @override
//   Future<Either<Failure, User>> login({required String accessToken}) async{
//     try{
//       User user =  await userRemoteDataSource.login(accessToken: accessToken);
//       return Right(user);
//     }
//     catch(exp){
//       return Left(ServerFailure());
//     }
//   }
//
//   @override
//   Future<Either<Failure, User>> loginWithEmail({required String email, required String password}) async{
//     try{
//       User user =  await userRemoteDataSource.loginWithEmail(email: email, password: password);
//       return Right(user);
//     }
//     catch(exp){
//       return Left(ServerFailure());
//     }
//   }
//
//
//   @override
//   Future<Either<Failure, User>> userRegister({required String name, required String email, required String password, required String phone, required String city, required String age, required String gender}) async{
//     try{
//       User user =  await userRemoteDataSource.userRegister(name: name, email: email, password: password, phone: phone, city: city, age: age, gender: gender);
//       return Right(user);
//     }
//     catch(exp){
//       return Left(ServerFailure());
//     }
//   }
//
//
// }
