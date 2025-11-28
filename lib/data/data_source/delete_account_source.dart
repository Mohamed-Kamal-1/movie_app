
import 'package:movie_app/api/model/profile/delete_account_dto.dart';

abstract interface class DeleteAccountSource {


  Future<DeleteAccountDto> updateProfile(String email , int avatarId);

  String getErrorMessage();

  String getErrorStatusCode();
}