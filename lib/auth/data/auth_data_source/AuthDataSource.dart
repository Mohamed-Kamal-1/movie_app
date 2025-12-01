import '../models/register_model.dart';

abstract class AuthDataSource {

  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  });
}
