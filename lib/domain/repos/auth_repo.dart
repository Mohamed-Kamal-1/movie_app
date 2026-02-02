import '../api_result.dart';
import '../model/entities/auth_result.dart';


abstract interface class AuthRepo {
  Future<Result<AuthResult>> login(String email, String password);
  Future<Result<AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  });

}

