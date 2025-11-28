import '../api_result.dart';

abstract interface class DeleteAccountRepo {


  Future<Result<DeleteAccountRepo>> deleteAccount();
  String getErrorMessage();

}