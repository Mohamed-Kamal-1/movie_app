import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/model/entities/user_entity.dart';
import 'package:movie_app/domain/use_case/delete_account_use_case.dart';
import 'package:movie_app/domain/use_case/profile_use_case.dart';
import 'package:movie_app/domain/use_case/update_profile_use_case.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';
import 'package:movie_app/ui/user_profile_Screen/user_info.dart';

import '../../../SharedPreferences/auth_shared_preferences.dart';
import '../../../domain/api_result.dart';
import '../../../domain/model/movie_model.dart';
import '../../../domain/use_case/movies_list.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileScreenState> {
  final ProfileUseCase _useCase;
  final UpdateProfileUseCase _updateUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  MoviesListUseCase moviesListUseCase;
  List<MovieModel>? listOfMovies;

  ProfileViewModel(
    this._useCase,
    this._updateUseCase,
    this._deleteAccountUseCase,
    this.moviesListUseCase,
  ) : super(ProfileInitialState());

  Future<void> getProfile() async {
    emit(ProfileLoadingState());
    String? name = UserInfo().getName();
    if (name != null && name.isNotEmpty) {

      emit(ProfileSuccessState(name: name));
    } else {
      emit(ProfileErrorState(errorMessage: Exception('user Not Found')));
    }
  }

  // Future<void> updateData(String mail, int avatarId) async {
  //   emit(ProfileLoadingState());
  //   try {
  //     final res = await _updateUseCase.updateProfile(mail, avatarId);
  //     getProfile();
  //   } catch (e) {
  //     emit(ProfileErrorState(e.toString()));
  //   }
  // }

  // Future<void> deleteAcc() async {
  //   emit(ProfileLoadingState());
  //   try {
  //     await _deleteAccountUseCase.deleteAccount();
  //     print("acc deleted");
  //   } catch (e) {
  //     emit(ProfileErrorState(e.toString()));
  //   }
  // }

  Future<void> getProfileMovies(String dateAdded) async {
    emit(ProfileLoadingState());

    final response = await moviesListUseCase.getMoviesList(
        dateAdded: dateAdded,
      );

    switch (response) {
      case Success<List<MovieModel>>():
        {
          emit(ProfileMoviesListLoaded(response.data));
        }

      case Failure<List<MovieModel>>():
        {
          emit(ProfileErrorState(errorMessage: response.exception));
        }
    }
  }
}
