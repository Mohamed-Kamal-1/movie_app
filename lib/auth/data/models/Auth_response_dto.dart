import '../../domain/entities/auth_result.dart';
import 'User.dart';

class AuthResponseDto {
  AuthResponseDto({
    // this.message,
    this.user,
    this.token,
  });

  AuthResponseDto.fromJson(dynamic json) {
    // message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  // String? message;
  User? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  AuthResult convertIntoAuthResult() {
    return AuthResult(user: user?.convertIntoUserEntity(), token: token);
  }
}
