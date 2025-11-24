import 'package:movie_app/domain/model/movie_model.dart';

abstract interface class MoviesListDataSource{
  Future<List<MovieModel>> getMoviesList(String dateAdded);
  String getErrorMessage();
}