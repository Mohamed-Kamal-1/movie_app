import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/endpoints/endpoints.dart';
import 'package:movie_app/api/model/movie_list/movie_response_dto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class ApiManager {
  final dio = Dio();
  static const String _baseUrl = 'https://yts.lt/api/v2/';

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
        throw Exception('connection Time out ');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('connection Time out');
      }
      rethrow;
    }
  }
}
