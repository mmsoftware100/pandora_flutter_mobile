

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class userRepository{

  Future<Either<Failure,User>> login({
  required String accessToken
});
  
}