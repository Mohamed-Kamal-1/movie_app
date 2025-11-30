
import 'package:movie_app/api/model/profile/delete_account_dto.dart';

abstract interface class DeleteAccountSource {


  Future<DeleteAccountDto> deleteAccount();

  String getErrorMessage();

  String getErrorStatusCode();
}