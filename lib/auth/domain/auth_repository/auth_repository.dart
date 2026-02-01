// import 'package:dartz/dartz.dart';
import 'package:movie_app/auth/domain/entities/auth_result.dart';
import 'package:movie_app/core/errors/failure.dart';

import '../../../domain/api_result.dart';

abstract class AuthRepository {
  // Future<Either<Failure, AuthResult>> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String confirmPassword,
  //   required String phone,
  //   // required int avaterId,
  // });
  Future<Result<AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });
}
