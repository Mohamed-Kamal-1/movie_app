import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/repos/auth_repo.dart';
import 'package:movie_app/ui/login_screen/login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final AuthRepo _loginAuthRepo;

  LoginViewModel(this._loginAuthRepo) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final response = await _loginAuthRepo.login(email, password);
    switch (response) {
      case Success():
        {
          if (response.data.token != null) {
            await AuthSharedPreferences.init();
            await AuthSharedPreferences.saveToken(response.data.token!);
          }
        emit(LoginSuccessState());
      }

      case Failure():
        emit(LoginErrorState(errorMessage: response.exception));
    }
  }

  // Future<void> loginWithGoogle() async {
  //   try {
  //     emit(LoginLoadingState());
  //
  //     // TODO: Implement Google login logic here
  //     // For now, just show error that it's not implemented
  //     emit(LoginErrorState(
  //       errorMessage: 'Google login is not yet implemented',
  //     ));
  //   } catch (e) {
  //     emit(LoginErrorState(errorMessage: e.toString()));
  //   }
  // }
}

