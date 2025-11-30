import '../api_result.dart';
import '../model/user_model.dart';

abstract interface class AuthRepo {
  Future<Result<UserModel>> login(String email, String password);
  String getErrorMessage();
}

