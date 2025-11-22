import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/auth/domain/auth_repository/auth_repository.dart';
import 'package:movie_app/auth/presentation/auth_cubit/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _repository;

  RegisterCubit(this._repository) : super(InitState());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    emit(LoadingState());

    final result = await _repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avaterId: avaterId,
    );

    result.fold((l) => emit(ErrorState(message: l.message)), (r) => emit(SuccessState(r)));
  }
}
