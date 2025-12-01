import 'package:movie_app/auth/domain/entities/auth_result.dart';

abstract class RegisterState {}
class InitState extends RegisterState {}

class LoadingState extends RegisterState {}

class ErrorState extends RegisterState {
  final String message;

  ErrorState({required this.message});
}

class SuccessState extends RegisterState {
  final AuthResult authResult;

  SuccessState(this.authResult);
}
