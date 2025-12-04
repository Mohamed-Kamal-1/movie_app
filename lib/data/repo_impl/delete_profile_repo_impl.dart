import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/delete_account_dto.dart';

import '../../domain/repos/delete_account_repo.dart';
import '../data_source/delete_account_source.dart';

@Injectable(as : DeleteAccountRepo)

class DeleteAccountRepoImpl implements DeleteAccountRepo {

  final DeleteAccountSource deleteAccountSource;

  DeleteAccountRepoImpl(this.deleteAccountSource);


  @override
  Future<DeleteAccountDto> deleteAccount() async {
    return await deleteAccountSource.deleteAccount();
  }

  @override
  String getErrorMessage() {
    return deleteAccountSource.getErrorMessage();
  }


}