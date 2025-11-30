import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/login/login_response.dart';
import 'package:movie_app/data/data_source/auth_data_source.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final ApiManager apiManager;
  String? errorMessage;

  AuthDataSourceImpl(this.apiManager);

  @override
  Future<LoginResponseDto> login(String email, String password) async {
    try {
      errorMessage = null;
      return await apiManager.login(email, password);
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      rethrow;
    }
  }

  @override
  String getErrorMessage() {
    return errorMessage ?? 'Login failed';
  }
}

