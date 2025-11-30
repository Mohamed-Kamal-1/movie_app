/// message : "Success Login"
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5MjVkYzJmNWIwZjI0YTJlNmU3MzhjNCIsImVtYWlsIjoibW8yQGdtYWlsLmNvbSIsImlhdCI6MTc2NDA4ODkyN30.TH9bYSy_mG_GO9bcN_4O4kvrGYnqABz9um5jJOPvG6Y"


class LoginResponseDto {
  LoginResponseDto({String? message, String? data}) {
    _message = message;
    _data = data;
  }

  LoginResponseDto.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'];
  }
  String? _message;
  String? _data;
  LoginResponseDto copyWith({String? message, String? data}) =>
      LoginResponseDto(message: message ?? _message, data: data ?? _data);
  String? get message => _message;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
