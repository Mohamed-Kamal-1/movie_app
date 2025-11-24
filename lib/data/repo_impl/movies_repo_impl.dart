import 'package:injectable/injectable.dart';
import 'package:movie_app/data/data_source/movies_list_data_source.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../domain/repos/movies_repo.dart';

@Injectable(as: MoviesRepo)
class MoviesRepoImpl implements MoviesRepo {
  MoviesListDataSource moviesListDataSource;

  MoviesRepoImpl(this.moviesListDataSource);

  @override
  Future<List<MovieModel>> getMoviesList(String dateAdded) async {
    return await moviesListDataSource.getMoviesList(dateAdded);
  }

  @override
  String getErrorMessage() {
    return moviesListDataSource.getErrorMessage();
  }
}
