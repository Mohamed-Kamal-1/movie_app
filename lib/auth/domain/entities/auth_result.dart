import 'package:movie_app/auth/domain/entities/user_entity.dart';

// class AuthResult {
//   final String message;
//   final DataModel? data;
//
//   AuthResult({required this.message, required this.data});
// }


class AuthResult {
  AuthResult({
    // this.message,
    this.user,
    this.token,});


  // String? message;
  UserEntity? user;
  String? token;


}
