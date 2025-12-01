import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/endpoints/endpoints.dart';
import 'package:movie_app/api/model/movie_list/movie_response_dto.dart';
import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';
import 'package:movie_app/SharedPreferences/auth_shared_preferences.dart';
import 'package:movie_app/api/model/profile/delete_account_dto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'model/login/login_response.dart';
import 'model/profile/profile_response_dto.dart';
import 'model/profile/update_profile_dto.dart';

@singleton
class ApiManager {
  final dio = Dio();
  final authDio = Dio();
  static const String _baseUrl = 'https://yts.lt/api/v2/';
  static const String _authBaseUrl = 'https://route-movie-apis.vercel.app/';

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


    authDio.options.baseUrl = _authBaseUrl;
    authDio.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        responseHeader: true,
        error: true,
        requestHeader: true,
        requestBody: true,
      ),
    );
  }

  Future<MovieResponseDto> getMoviesList(String dateAdded) async {
    try {
      Map<String, String> parameter = {
        'sort_by': dateAdded,
        'order_by': 'desc',
      };
      Response response = await dio.get(
        Endpoints.moviesList,
        queryParameters: parameter,
      );
      MovieResponseDto movieResponse = MovieResponseDto.fromJson(response.data);
      if (movieResponse.status == 'ok') {
        return movieResponse;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: "Failed to load Movies",
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('connection Time out');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('connection Time out ');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('connection Time out');
      }
      rethrow;
    }
  }
  Future<LoginResponseDto> login(String email, String password) async {
    try {
      Response response = await authDio.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      // Check if response status code indicates success (200-299)
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return LoginResponseDto.fromJson(response.data);
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
          throw Exception(errorData['message'] ?? 'Login failed');
        }
        throw Exception('Login failed. Please try again.');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetailsResponseDto> getMovieDetails(String movieId) async {
    try {
      Map<String, String> parameter = {
        'movie_id': movieId,
        'with_cast': 'true',
        'with_images': 'true',
      };
      Response response = await dio.get(
        Endpoints.getMovieDetails,
        queryParameters: parameter,
      );
      MovieDetailsResponseDto movieDetailsResponse = MovieDetailsResponseDto.fromJson(response.data);
      if (movieDetailsResponse.status == 'ok') {
        return movieDetailsResponse;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          message: "Failed to load Movie Details",
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

  Future<MovieSuggestionResponseDto> getMovieSuggestion(String movieId) async {
    try {
      Map<String, String> parameter = {
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
      Response response = await authDio.post(
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
      Response response = await authDio.get(
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
      Response response = await authDio.get(
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
      Response response = await authDio.delete(
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
    try {
      Response response = await authDio.get(
        Endpoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MmNiOWI1NDYwNTE4YTYyOGFlNDE5NSIsImVtYWlsIjoibW9oQDQ1NmdtYWlsLmNvbSIsImlhdCI6MTc2NDUzODk4MH0.O9BrX_F6mJ85ZTyxlmAooJNJXM8JnjiVx-6kPNqGOfs",
          },
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
    try {
      Response response = await authDio.put(
        Endpoints.profile,
        data: {
          'email': email,
          'avaterId': avatarId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MmNiOWI1NDYwNTE4YTYyOGFlNDE5NSIsImVtYWlsIjoibW9oQDQ1NmdtYWlsLmNvbSIsImlhdCI6MTc2NDUzODk4MH0.O9BrX_F6mJ85ZTyxlmAooJNJXM8JnjiVx-6kPNqGOfs",
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
    try {
      Response response = await authDio.delete(
        Endpoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MmNiOWI1NDYwNTE4YTYyOGFlNDE5NSIsImVtYWlsIjoibW9oQDQ1NmdtYWlsLmNvbSIsImlhdCI6MTc2NDUzODk4MH0.O9BrX_F6mJ85ZTyxlmAooJNJXM8JnjiVx-6kPNqGOfs",
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
