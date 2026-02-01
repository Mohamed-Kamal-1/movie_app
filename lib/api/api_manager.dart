import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';
import 'package:movie_app/api/endpoints/endpoints.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';
import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';
import 'package:movie_app/api/model/movie_list/movie_response_dto.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';
import 'package:movie_app/api/model/profile/delete_account_dto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../auth/data/models/Auth_response_dto.dart';
import 'model/profile/profile_response_dto.dart';
import 'model/profile/update_profile_dto.dart';

@singleton
class ApiManager {
  final dio = Dio();
  final authAndUpdateDio = Dio();
  static const String _baseUrl = 'https://yts.lt/api/v2/';
  static const String _authAndUpdateBaseUrl = 'https://ecommerce.routemisr.com/';

  ApiManager() {
    dio.options.baseUrl = _baseUrl;
    dio.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        responseHeader: true,
        error: true,
        requestHeader: true,
        requestBody: true,
      ),
    );


    authAndUpdateDio.options.baseUrl = _authAndUpdateBaseUrl;
    authAndUpdateDio.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        responseHeader: true,
        error: true,
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  Future<MovieResponseDto> getMoviesList(
      {String dateAdded = "date_added" , String queryTerm = '0',limit = '20'}) async {
      Map<String, String> parameter = {
        'sort_by': dateAdded ,
        'order_by': 'desc',
        'limit' : limit,
        'movie_count':'10',
        'query_term' : queryTerm,
      };
      Response response = await dio.get(
        Endpoints.moviesList,
        queryParameters: parameter,
      );
      MovieResponseDto movieResponse = MovieResponseDto.fromJson(response.data);
        return movieResponse;
  }



  Future<MovieResponseDto> getMoviesListByGenres(String genre) async {
    Map<String, String> parameter = {'genre': genre, 'limit': '10',
        'movie_count':'10',};
      Response response = await dio.get(
        Endpoints.moviesList,
        queryParameters: parameter,
      );
      MovieResponseDto movieResponse = MovieResponseDto.fromJson(response.data);
        return movieResponse;
  }

  Future<MovieDetailsResponseDto> getMovieDetails(int movieId) async {
    Map<String, Object> parameter = {
        'movie_id': movieId,
        'with_cast': 'true',
        'with_images': 'true',
      };
      Response response = await dio.get(
        Endpoints.getMovieDetails,
        queryParameters: parameter,
      );
      MovieDetailsResponseDto movieDetailsResponse = MovieDetailsResponseDto.fromJson(response.data);
        return movieDetailsResponse;
  }


  Future<AuthResponseDto> login(String email, String password) async {

    Map<String, Object> bodyData = {
      "email": email,
      "password": password,
    };
    final Response response = await dio.post(
      Endpoints.register,
      data: bodyData,
    );

    final AuthResponseDto authResponse = AuthResponseDto.fromJson(
        response.data);

    return authResponse;
  }

  Future<AuthResponseDto> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    Map<String, Object> bodyData = {

      "name": name,
      "email": email,
      "password": password,
      "rePassword": confirmPassword,
      "phone": phone,

    };
    final Response response = await dio.post(
      Endpoints.register,
      data: bodyData,

    );

    final AuthResponseDto authResponse = AuthResponseDto.fromJson(
        response.data);

    return authResponse;
  }


  Future<MovieSuggestionResponseDto> getMovieSuggestion(int movieId) async {
    try {
      Map<String, int> parameter = {
        'movie_id': movieId,
      };
      Response response = await dio.get(
        Endpoints.getMovieSuggestion,
        queryParameters: parameter,
      );
      MovieSuggestionResponseDto suggestionResponse =
          MovieSuggestionResponseDto.fromJson(response.data);
      if (suggestionResponse.status == 'ok') {
        return suggestionResponse;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: "Failed to load Movie Suggestions",
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('connection Time out ');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('connection Time out');
      }
      rethrow;
    }
  }

  Future<AddToFavouriteResponseModel?> addToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) async {
    try {
      final token = AuthSharedPreferences.getToken();
      Response response = await authAndUpdateDio.post(
        Endpoints.addToFavourite,
        data: {
          "movieId": addFavouriteData.movieId,
          'name': addFavouriteData.name,
          'rating': addFavouriteData.rating,
          'imageURL': addFavouriteData.imageURL,
          'year': addFavouriteData.year
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AddToFavouriteResponseModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      }
      rethrow;
    }
  }

  Future<GetAllFavouriteModel?> getAllFavourite() async {
    try {
      final token = AuthSharedPreferences.getToken();
      Response response = await authAndUpdateDio.get(
        Endpoints.getAllFavourite,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return GetAllFavouriteModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      }
      rethrow;
    }
  }

  Future<IsFavouriteModel?> isFavourite(String movieId) async {
    try {
      final token = AuthSharedPreferences.getToken();
      Response response = await authAndUpdateDio.get(
        '${Endpoints.isFavourite}/$movieId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return IsFavouriteModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      }
      rethrow;
    }
  }

  Future<RemoveFromFavouriteModel?> removeFromFavourite(String movieId) async {
    try {
      final token = AuthSharedPreferences.getToken();
      Response response = await authAndUpdateDio.delete(
        '${Endpoints.removeFromFavourite}/$movieId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return RemoveFromFavouriteModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      }
      rethrow;
    }
  }

  // TODO
  // profile API
  Future<ProfileResponseDto> getProfile()  async {
    final token = AuthSharedPreferences.getToken();
    try {
      Response response = await authAndUpdateDio.get(
        Endpoints.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ProfileResponseDto.fromJson(response.data);
      } else {
        // Handle non-success status codes
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors (network, timeout, etc.)
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      } else if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Parse error response
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('message')) {
          throw Exception(errorData['message'] ?? 'get profile failed');
        }
        throw Exception('get profile failed. Please try again.');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      rethrow;
    }
  }

  // updateProfile


  Future<UpdateProfileDto> updateProfile(String email , int avatarId)  async {
    final token = AuthSharedPreferences.getToken();
    try {
      Response response = await authAndUpdateDio.patch(
        Endpoints.profile,
        data: {
          'email': email,
          'avaterId': avatarId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return UpdateProfileDto.fromJson(response.data);
      } else {
        // Handle non-success status codes
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors (network, timeout, etc.)
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      } else if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Parse error response
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('message')) {
          throw Exception(errorData['message'] ?? 'update profile failed');
        }
        throw Exception('update profile failed. Please try again.');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteAccountDto> deleteAccount()  async {
    final token = AuthSharedPreferences.getToken();
    try {
      Response response = await authAndUpdateDio.delete(
        Endpoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return DeleteAccountDto.fromJson(response.data);
      } else {
        // Handle non-success status codes
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio errors (network, timeout, etc.)
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timeout. Please try again.');
      } else if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Parse error response
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('message')) {
          throw Exception(errorData['message'] ?? 'delete account failed');
        }
        throw Exception('delete account failed. Please try again.');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
