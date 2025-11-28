import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/profile_response_dto.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/use_case/profile_use_case.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileScreenState> {
  ProfileUseCase _useCase;

  ProfileViewModel(this._useCase) : super(ProfileInitialState());

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    try  {
    final res = await _useCase.getProfile();
    emit(ProfileSuccessState(res));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
