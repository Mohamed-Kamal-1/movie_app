import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/auth/data/models/register_model.dart';
import 'package:movie_app/core/app_const/app_const.dart';
import 'AuthDataSource.dart';

@injectable
class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl(this.dio);

  @override
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

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RegisterModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message']);
    }
  }
}
