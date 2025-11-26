import 'package:movie_app/domain/model/movie_model.dart';

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
