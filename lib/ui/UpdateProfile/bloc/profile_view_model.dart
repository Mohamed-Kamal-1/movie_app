import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/use_case/delete_account_use_case.dart';
import 'package:movie_app/domain/use_case/profile_use_case.dart';
import 'package:movie_app/domain/use_case/update_profile_use_case.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';

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
    try {
      final res = await _useCase.getProfile();
      emit(ProfileSuccessState(res));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> updateData(String mail, int avatarId) async {
    emit(ProfileLoadingState());
    try {
      final res = await _updateUseCase.updateProfile(mail, avatarId);
      getProfile();
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> deleteAcc() async {
    emit(ProfileLoadingState());
    try {
      await _deleteAccountUseCase.deleteAccount();
      print("acc deleted");
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> getProfileMovies(String dateAdded) async {
    List<MovieModel> response = await moviesListUseCase.getMoviesList(
      dateAdded,
    );
    if (response.isEmpty) {
      emit(ProfileMoviesListLoaded([]));
    } else {
      emit(ProfileMoviesListLoaded(response));
    }
  }
}
