import 'package:movie_app/auth/data/models/data_model.dart';

class AuthResult {
  final String message;
  final DataModel? data;

  AuthResult({required this.message, required this.data});
}
