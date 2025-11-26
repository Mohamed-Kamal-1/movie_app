import '../model/movie_model.dart';

abstract interface class MoviesRepo{

  Future<List<MovieModel>> getMoviesList(String dateAdded);
  String getErrorMessage();
  String getErrorStatusCode();
}