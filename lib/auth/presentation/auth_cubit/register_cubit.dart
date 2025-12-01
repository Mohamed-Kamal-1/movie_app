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

    try {
      final result = await _repository.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avaterId: avaterId,
      );

      result.fold(
        (failure) {
          print("Register failed: ${failure.message}");
          emit(ErrorState(message: failure.message));
        },
        (authResult) {
          print("Register success: ${authResult.data}");
          // لو data موجودة استخدمها، ولو لأ خلي SuccessState من غير مشاكل
          emit(SuccessState(authResult));
        },
      );
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
