abstract class Endpoints {
  static const String moviesList = 'list_movies.json';
  static const String login = "/api/v1/auth/signin";
  static const String register = 'api/v1/auth/signup';
  static const String getMovieDetails = 'https://yts.lt/api/v2/movie_details.json';
  static const String getMovieSuggestion ='https://yts.lt/api/v2/movie_suggestions.json';
  static const String addToFavourite ='https://yts.lt/api/v2/favorites/add';
  static const String getAllFavourite =  'https://yts.lt/api/v2/favorites/all';
  static const String isFavourite = 'https://yts.lt/api/v2/favorites/is-favorite';
  static const String removeFromFavourite = 'https://yts.lt/api/v2/favorites/remove';
static const String profile = "/api/v1/users/updateMe/";
}