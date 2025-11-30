import 'package:movie_app/api/model/login/login_response.dart';

abstract interface class AuthDataSource {
  Future<LoginResponseDto> login(String email, String password);
  String getErrorMessage();
}

