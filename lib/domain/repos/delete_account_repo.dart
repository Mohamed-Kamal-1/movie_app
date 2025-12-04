import 'package:movie_app/api/model/profile/delete_account_dto.dart';


abstract interface class DeleteAccountRepo {


  Future<DeleteAccountDto> deleteAccount();
  String getErrorMessage();

}