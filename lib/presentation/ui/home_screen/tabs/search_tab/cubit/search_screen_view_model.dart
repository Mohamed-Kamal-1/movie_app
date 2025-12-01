import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/search_tab/cubit/search_screen_state.dart';

import '../../../../../../domain/use_case/movies_list.dart';

@injectable
class SearchScreenViewModel extends Cubit<SearchScreenState> {
  MoviesListUseCase moviesListUseCase;
  String? _lastQuery;

  SearchScreenViewModel(this.moviesListUseCase) : super(SearchInitialState());

  Future<void> getMoviesListByTitle(String title) async {
    _lastQuery = title;
    var errorMessage = moviesListUseCase.getErrorMessage();
    if (title.isEmpty) {
      emit(SearchEmptyState(isEmpty: true));
      return;
    }
    try {
      emit(SearchLoadingState());
      List<MovieModel> response = await moviesListUseCase.getMoviesListByTitle(
        title,
      );
      if (_lastQuery != title) return;

      if (response.isEmpty) {
        emit(SearchErrorState(errorMessage: errorMessage));
      } else {
        emit(SearchSuccessState(moviesList: response));
      }
    } catch (e) {
      if (_lastQuery != title) return;
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
