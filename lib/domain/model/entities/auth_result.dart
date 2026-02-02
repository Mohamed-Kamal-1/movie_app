import 'package:movie_app/domain/model/entities/user_entity.dart';

class AuthResult {
  AuthResult({

    this.user,
    this.token,});


  UserEntity? user;
  String? token;


}
