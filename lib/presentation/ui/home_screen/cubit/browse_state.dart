part of 'browse_cubit.dart';

abstract class BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseError extends BrowseState {
  final String message;
  BrowseError(this.message);
}

class BrowseLoaded extends BrowseState {
  final List<MovieModel> movies;
  final List<String> genres;
  final String selectedGenre;

  BrowseLoaded({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}
