class ErrorResponseDto {
  int? statusCode;
  String? message;

  ErrorResponseDto({
    this.statusCode,
    this.message,
  });

  ErrorResponseDto.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    return map;
  }
}

