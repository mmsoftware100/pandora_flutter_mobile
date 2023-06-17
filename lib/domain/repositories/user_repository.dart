

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository{

  Future<Either<Failure,User>> login({
  required String accessToken
  });

  Future<Either<Failure,User>> loginWithEmail({
    required String email,
    required String password,
  });

}