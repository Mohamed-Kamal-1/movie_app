import 'package:injectable/injectable.dart';
import 'package:movie_app/api/execute_api.dart';

import '../../../domain/api_result.dart';
import '../../domain/auth_repository/auth_repository.dart';
import '../../domain/entities/auth_result.dart';
import '../auth_data_source/AuthDataSourceImpl.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSourceImpl _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Result<AuthResult>> register({required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone}) async {
    return executeApi(() async {
      final response = await _authDataSource.register(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          phone: phone);
      return response.convertIntoAuthResult();
    },);
  }


}
