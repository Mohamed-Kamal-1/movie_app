import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/endpoints/endpoints.dart';
import 'package:movie_app/api/model/movie_list/movie_response_dto.dart';
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
      Map<String, String> parameter = {'sort_by': dateAdded};
      Response response = await dio.get(
        Endpoints.moviesList,
        queryParameters: parameter,
      );
      MovieResponseDto movieResponse = MovieResponseDto.fromJson(response.data);
      if (movieResponse.status == 'ok') {
        return movieResponse;
      }
      else {
        throw DioException(

          requestOptions: response.requestOptions,
          message: "Failed to load Movies",
        );
      }

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('connection Time out');
      }  else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('connection Time out');
      }
      rethrow;
    }
  }


  Future<MovieResponseDto> getMoviesListByGenres(String genre) async {
    try {
      Map<String, String> parameter = {'genre': genre};
      Response response = await dio.get(
        Endpoints.moviesList,
        queryParameters: parameter,
      );
      MovieResponseDto movieResponse = MovieResponseDto.fromJson(response.data);
      if (movieResponse.status == 'ok') {
        return movieResponse;
      }
      else {
        throw DioException(

          requestOptions: response.requestOptions,
          message: "Failed to load Movies",
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

  // TODO
  // profile API
  Future<ProfileResponseDto> getProfile()  async {
    try {
      Response response = await authDio.get(
        Endpoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MjlkZThlNDVhMDA2ZWEzMTQ3MDZjNiIsImVtYWlsIjoidGlqb2NpajQwM0BodHRwc3UuY29tIiwiaWF0IjoxNzY0MzUxNjQ4fQ.fBR94z6kxx3c8WZz16ZQ-S52Yu3Eqe4rNFugROoSirc",
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
      Response response = await authDio.patch(
        Endpoints.profile,
        data: {
          'email': email,
          'avaterId': avatarId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MjlkZThlNDVhMDA2ZWEzMTQ3MDZjNiIsImVtYWlsIjoidGlqb2NpajQwM0BodHRwc3UuY29tIiwiaWF0IjoxNzY0MzUxNjQ4fQ.fBR94z6kxx3c8WZz16ZQ-S52Yu3Eqe4rNFugROoSirc",
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
      Response response = await authDio.patch(
        Endpoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MjlkZThlNDVhMDA2ZWEzMTQ3MDZjNiIsImVtYWlsIjoidGlqb2NpajQwM0BodHRwc3UuY29tIiwiaWF0IjoxNzY0MzUxNjQ4fQ.fBR94z6kxx3c8WZz16ZQ-S52Yu3Eqe4rNFugROoSirc",
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
