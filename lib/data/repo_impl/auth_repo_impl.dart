import 'package:injectable/injectable.dart';
import 'package:movie_app/data/data_source/auth_data_source.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/user_model.dart';
import 'package:movie_app/domain/repos/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);

  @override
  Future<Result<UserModel>> login(String email, String password) async {
    try {
      final response = await authDataSource.login(email, password);
      
      // Extract token from response (response.data contains the token)
      if (response.data != null && response.data!.isNotEmpty) {
        final userModel = UserModel(
          email: email,
          token: response.data,
        );
        return Success(userModel);
      } else {
        return Failure(Exception(authDataSource.getErrorMessage()));
      }
    } catch (e) {
      return Failure(Exception(authDataSource.getErrorMessage()));
    }
  }

  @override
  String getErrorMessage() {
    return authDataSource.getErrorMessage();
  }
}

