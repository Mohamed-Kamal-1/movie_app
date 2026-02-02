
import '../../domain/api_result.dart';
import '../../domain/model/entities/auth_result.dart';

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

