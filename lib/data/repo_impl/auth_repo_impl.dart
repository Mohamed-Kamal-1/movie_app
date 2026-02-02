import 'package:injectable/injectable.dart';
import 'package:movie_app/data/data_source/auth_data_source.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/repos/auth_repo.dart';

import '../../domain/model/entities/auth_result.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);


  @override
  Future<Result<AuthResult>> login(String email, String password) {
    return authDataSource.login(email, password);
  }

  @override
  Future<Result<AuthResult>> register(
      {required String name, required String email, required String password, required String confirmPassword, required String phone}) {
    return authDataSource.register(name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone);
  }


}

