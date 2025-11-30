import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/delete_account_dto.dart';
import 'package:movie_app/data/data_source/delete_account_source.dart';

import '../api_manager.dart';

@Injectable(as: DeleteAccountSource)
class DeleteAccountSoucreImpl implements DeleteAccountSource {
  ApiManager apiManager;
  String? errorMessage;

  DeleteAccountSoucreImpl(this.apiManager);

  @override
  String getErrorMessage() {
    return errorMessage ?? 'not Found';
  }

  @override
  String getErrorStatusCode() {
    // TODO: implement getErrorStatusCode
    throw UnimplementedError();
  }

  @override
  Future<DeleteAccountDto> deleteAccount() async {
    return await apiManager.deleteAccount();
  }
}
