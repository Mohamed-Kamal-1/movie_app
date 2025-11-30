import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/watch_now_state.dart';
import '../../../../domain/model/movie_model.dart';
import '../../../../domain/use_case/movies_list.dart';
@injectable
class WatchNowViewModel extends Cubit<WatchNowState> {
  final MoviesListUseCase moviesUseCase;

  WatchNowViewModel(this.moviesUseCase) : super(WatchNowInitial());

  Future<void> getMoviesListByGenres(String genre) async {
    var errorMessage = moviesUseCase.getErrorMessage();
    try {
      emit(WatchNowLoading());
      List<MovieModel> response = await moviesUseCase.getMoviesListByGenres(genre);
      if (response.isEmpty) {
        emit(WatchNowError(errorMessage: errorMessage));
      } else {
        emit(WatchNowSuccess(moviesList: response));
      }
    } catch (e) {
      emit(WatchNowError(errorMessage: e.toString()));
    }
  }
}
