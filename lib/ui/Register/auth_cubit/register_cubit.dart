import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/ui/Register/auth_cubit/register_state.dart';

import '../../../SharedPreferences/auth_shared_preferences.dart';
import '../../../domain/api_result.dart';
import '../../../domain/repos/auth_repo.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _repository;
  RegisterCubit(this._repository) : super(InitState());
  bool isAuthorized = false;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    emit(LoadingState());

    final authResponse = await _repository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );

    switch (authResponse) {
      case Success():
        if (authResponse.data.token != null) {
         await Future.wait([
            AuthSharedPreferences.saveEmail(
                authResponse.data.user?.email ?? ''),
            AuthSharedPreferences.saveName(authResponse.data.user?.name ?? ''),
            AuthSharedPreferences.saveToken(authResponse.data.token!),
          ]);

          isAuthorized = true;
        }

        emit(SuccessState(authResponse.data));
        break;

      case Failure():
        emit(ErrorState(message: authResponse.exception));
        break;
    }
  }

  // Future<void> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String confirmPassword,
  //   required String phone,
  //   // required int avaterId,
  // }) async {
  //   emit(LoadingState());
  //
  //   try {
  //     final result = await _repository.register(
  //       name: name,
  //       email: email,
  //       password: password,
  //       confirmPassword: confirmPassword,
  //       phone: phone,
  //       // avaterId: avaterId,
  //     );
  //
  //
  //
  //     result.fold(
  //       (failure) {
  //         print("Register failed: ${failure.message}");
  //         emit(ErrorState(message: failure.message));
  //       },
  //       (authResult) {
  //         print("Register success: ${authResult.data}");
  //         // لو data موجودة استخدمها، ولو لأ خلي SuccessState من غير مشاكل
  //         emit(SuccessState(authResult));
  //       },
  //     );
  //   } catch (e) {
  //     emit(ErrorState(message: e.toString()));
  //   }
  // }
}
