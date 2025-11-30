import 'movies_dto.dart';

class DataDto {
  DataDto({
      this.movieCount, 
      this.limit, 
      this.pageNumber, 
      this.movies,});

  DataDto.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesDto.fromJson(v));
      });
    }
  }
  num? movieCount;
  num? limit;
  num? pageNumber;
  List<MoviesDto>? movies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    map['limit'] = limit;
    map['page_number'] = pageNumber;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}