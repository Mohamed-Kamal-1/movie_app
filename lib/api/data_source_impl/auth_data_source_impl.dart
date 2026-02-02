import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/execute_api.dart';
import 'package:movie_app/data/data_source/auth_data_source.dart';
import 'package:movie_app/domain/api_result.dart';

import '../../domain/model/entities/auth_result.dart';
import '../model/authentication/Auth_response_dto.dart';


@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiManager apiManager;
  String? errorMessage;

  AuthDataSourceImpl(this.apiManager);



  @override
  Future<Result<AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    return executeApi(() async {
      final response = await apiManager.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
      );
      return response.convertIntoAuthResult();
    });
  }

  @override
  Future<Result<AuthResult>> login(String email, String password) async {
    return executeApi(() async {
      final AuthResponseDto response = await apiManager.login(email, password);
      return response.convertIntoAuthResult();
    },);
  }
}

