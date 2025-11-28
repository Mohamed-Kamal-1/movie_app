import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';

import '../../../../domain/use_case/movies_list.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState> {
  MoviesListUseCase moviesListUseCase;

  HomeScreenViewModel(this.moviesListUseCase) : super(HomeInitialState());

  Future<void> getMoviesList(String dateAdded) async {
    var errorMessage = moviesListUseCase.getErrorMessage();
    try {
      emit(HomeLoadingState());
      List<MovieModel> response = await moviesListUseCase.getMoviesList(
        dateAdded,
      );
      if (response.isEmpty) {
        emit(HomeErrorState(errorMessage: errorMessage));
      } else {
        emit(HomeSuccessState(moviesList: response));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getMoviesListByGenres(String genre) async {
    var errorMessage = moviesListUseCase.getErrorMessage();
    try {
      emit(HomeLoadingState());
      List<MovieModel> response = await moviesListUseCase.getMoviesList(genre);
      if (response.isEmpty) {
        emit(HomeErrorState(errorMessage: errorMessage));
      } else {
        emit(HomeSuccessState(moviesList: response));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
  void moveAnotherTab(int index){
    emit(MoveToAnotherTabState(index: index));
  }
}

