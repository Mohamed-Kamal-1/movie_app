import 'package:movie_app/api/model/profile/delete_account_dto.dart';

import '../api_result.dart';

abstract interface class DeleteAccountRepo {


  Future<DeleteAccountDto> deleteAccount();
  String getErrorMessage();

}