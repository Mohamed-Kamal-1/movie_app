import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/auth/data/models/Auth_response_dto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/app_const/app_const.dart';

@injectable
class AuthDataSourceImpl {
  final Dio dio;

  AuthDataSourceImpl() : dio = Dio() {
    dio.options.baseUrl = 'https://ecommerce.routemisr.com/';
    dio.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        responseHeader: true,
        error: true,
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  Future<AuthResponseDto> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    final Response response = await dio.post(
      AppConst.registerEndPoint,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": confirmPassword,
        "phone": phone,
      },
    );

    final AuthResponseDto authResponse = AuthResponseDto.fromJson(
        response.data);

    return authResponse;

  }
}
