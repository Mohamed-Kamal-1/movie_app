import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/user_model.dart';
import 'package:movie_app/domain/use_case/login_use_case.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';
import 'package:movie_app/ui/login_screen/login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      
      final result = await loginUseCase.login(email, password);
      
      if (result is Success<UserModel>) {
        // Save token and email to SharedPreferences
        if (result.data.token != null) {
          await AuthSharedPreferences.init();
          await AuthSharedPreferences.saveToken(result.data.token!);
          await AuthSharedPreferences.saveEmail(email);
        }
        emit(LoginSuccessState());
      } else if (result is Failure<UserModel>) {
        final errorMessage = loginUseCase.getErrorMessage();
        emit(LoginErrorState(
          errorMessage: errorMessage,
        ));
      }
    } catch (e) {
      emit(LoginErrorState(
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoadingState());
      
      // TODO: Implement Google login logic here
      // For now, just show error that it's not implemented
      emit(LoginErrorState(
        errorMessage: 'Google login is not yet implemented',
      ));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}

