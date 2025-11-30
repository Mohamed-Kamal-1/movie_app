import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_screen.dart';

abstract class HomeScreenState {}

class HomeInitialState extends HomeScreenState {}

class HomeLoadingState extends HomeScreenState {}

class HomeErrorState extends HomeScreenState {
  String? errorMessage;

  HomeErrorState({this.errorMessage});
}

class HomeSuccessState extends HomeScreenState {
  List<MovieModel>? moviesList;

  // List<String>

  HomeSuccessState({this.moviesList});
}

class MoveToAnotherTabState extends HomeScreenState {
  final int? index;

  MoveToAnotherTabState({this.index});
}
