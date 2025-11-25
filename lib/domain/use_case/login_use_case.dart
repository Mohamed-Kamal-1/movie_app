import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/user_model.dart';
import 'package:movie_app/domain/repos/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<Result<UserModel>> login(String email, String password) {
    return authRepo.login(email, password);
  }

  String getErrorMessage() {
    return authRepo.getErrorMessage();
  }
}

