import 'package:dio/dio.dart';
import '../../../core/app_const/app_const.dart';
import '../models/register_model.dart';

class AuthDataSourceImpl {
  final Dio dio;

  AuthDataSourceImpl(this.dio);

  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    final response = await dio.post(
      AppConst.registerUrl,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avaterId,
      },
    );

    final data = response.data['data'];

    if (data is Map<String, dynamic>) {
      return RegisterModel.fromJson(data);
    } else {
      throw Exception("Invalid data format");
    }
  }
}
