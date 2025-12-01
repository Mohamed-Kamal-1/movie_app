import 'package:movie_app/domain/model/movie_model.dart';

abstract class SearchScreenState {}

class SearchInitialState extends SearchScreenState {}

class SearchLoadingState extends SearchScreenState {}

class SearchErrorState extends SearchScreenState {
  String? errorMessage;

  SearchErrorState({this.errorMessage});
}

class SearchSuccessState extends SearchScreenState {
  List<MovieModel>? moviesList;

  SearchSuccessState({this.moviesList});
}

class SearchEmptyState extends SearchSuccessState{
  bool? isEmpty ;
  SearchEmptyState({required this.isEmpty});

}
