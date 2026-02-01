abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  Exception errorMessage;

  LoginErrorState({required this.errorMessage});
}

class LoginSuccessState extends LoginState {}

