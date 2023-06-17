

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams>{
  final UserRepository userRepository;

  UserLogin({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(UserLoginParams params)async {
    return await userRepository.login(accessToken: params.accessToken);
  }
}



class UserLoginParams extends Equatable{
  final String accessToken;

  const UserLoginParams({required this.accessToken});

  @override
  List<Object> get props => [accessToken];

}