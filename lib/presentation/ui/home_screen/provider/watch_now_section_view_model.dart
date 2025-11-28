import 'package:flutter/cupertino.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../../../domain/use_case/movies_list.dart';

class WatchNowSectionViewModel extends ChangeNotifier {
  MoviesListUseCase moviesListUseCase;

  WatchNowSectionViewModel(this.moviesListUseCase);

  WatchNowSectionState state = WatchNowSectionState();

  void getMoviesListByGenres(String genre) async{
    try {
      var response = await moviesListUseCase.getMoviesListByGenres(genre);
      var errorMessage = moviesListUseCase.getErrorMessage();
      _sendState(
        WatchNowSectionState(
          loadingMessage: "please Wait...",
          state: ScreenState.Loading,
        ),
      );

      if (response.isEmpty) {
        _sendState(
          WatchNowSectionState(
            state: ScreenState.Error,
            errorMessage: errorMessage,
          ),
        );
      } else {
        _sendState(
          WatchNowSectionState(state: ScreenState.Success, movies: response),
        );
      }
    } catch (e) {
      _sendState(
        WatchNowSectionState(
          state: ScreenState.Error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _sendState(WatchNowSectionState newState) {
    state = newState;
    notifyListeners();
  }
}

enum ScreenState { initial, Loading, Success, Error }

class WatchNowSectionState {
  ScreenState state = ScreenState.initial;

  List<MovieModel>? movies;

  String? loadingMessage;
  String? errorMessage;

  WatchNowSectionState({
    this.state = ScreenState.initial,
    this.movies,
    this.loadingMessage,
    this.errorMessage,
  });
}
