import 'data_dto.dart';

class MovieResponseDto {
  MovieResponseDto({this.status, this.statusMessage, this.data, this.code});

  MovieResponseDto.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataDto.fromJson(json['data']) : null;
  }

  String? status;
  String? statusMessage;
  String? code;
  DataDto? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }

    return map;
  }
}
