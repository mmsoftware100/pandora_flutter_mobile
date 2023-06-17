
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pandora_flutter_mobile/domain/repositories/user_repository.dart';

import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/user.dart';

class LoginWithEmail implements UseCase<User, LoginWithEmailParams>{
  final UserRepository userRepository;

  LoginWithEmail({required this.userRepository});

  @override
  Future<Either<Failure,User>> call(LoginWithEmailParams params) async{
    return await userRepository.loginWithEmail(email: params.email, password: params.password);
  }
}

class LoginWithEmailParams extends Equatable{
  final String email;
  final String password;

  const LoginWithEmailParams({required this.email, required this.password});

  @override
  List<Object> get props => [email,password];
}