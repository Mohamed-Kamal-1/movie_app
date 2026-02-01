import 'package:movie_app/api/model/login/login_response.dart';
import 'package:movie_app/auth/domain/entities/auth_result.dart';

import '../../domain/api_result.dart';

abstract interface class AuthDataSource {
  Future<Result<AuthResult>> login(String email, String password);

  Future<Result<AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });


}

