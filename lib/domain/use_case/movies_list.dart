import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/repos/movies_repo.dart';

import '../model/movie_model.dart';
@injectable
class MoviesListUseCase{
  MoviesRepo moviesRepo;
  MoviesListUseCase(this.moviesRepo);

  Future<List<MovieModel>> getMoviesList(String dateAdded){
    return moviesRepo.getMoviesList(dateAdded);
  }
  String getErrorMessage(){
    return moviesRepo.getErrorMessage();
  }
}