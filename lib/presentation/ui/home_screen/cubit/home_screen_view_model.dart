import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';

import '../../../../domain/use_case/movies_list.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState> {
  MoviesListUseCase moviesListUseCase;

  HomeScreenViewModel(this.moviesListUseCase) : super(HomeInitialState());

  Future<void> getMoviesList(String dateAdded) async {
    try {
      emit(HomeLoadingState());
      var errorMessage = moviesListUseCase.getErrorMessage();
      List<MovieModel> response = await moviesListUseCase.getMoviesList(
        dateAdded,
      );
      if (response.isEmpty) {
        emit(HomeErrorState(errorMessage: errorMessage));
      }

      // else if (moviesListUseCase.moviesRepo.getErrorStatusCode() == '404') {
      //   emit(HomeErrorState(errorMessage: "404 not foumd ? "));
      // }


      else {
        emit(HomeSuccessState(moviesList: response));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getMoviesGenres(String dateAdded, int index) async {
    try {
      emit(HomeLoadingState());
      var errorMessage = moviesListUseCase.getErrorMessage();
      List<MovieModel> response = await moviesListUseCase.getMoviesList(
        dateAdded,
      );
      response[index].genres?.first ?? '';
      if (response.isEmpty) {
        emit(HomeErrorState(errorMessage: errorMessage));
      } else {
        emit(HomeSuccessState(moviesList: response));
      }
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
