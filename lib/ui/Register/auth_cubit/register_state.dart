
import '../../../domain/model/entities/auth_result.dart';

abstract class RegisterState {}
class InitState extends RegisterState {}

class LoadingState extends RegisterState {}

class ErrorState extends RegisterState {
  final Exception message;

  ErrorState({required this.message});
}

class SuccessState extends RegisterState {
  final AuthResult authResult;

  SuccessState(this.authResult);
}
