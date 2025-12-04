import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/delete_account_dto.dart';

import '../repos/delete_account_repo.dart';

@injectable
class DeleteAccountUseCase {
  final DeleteAccountRepo deleteAccountRepo;

  DeleteAccountUseCase(this.deleteAccountRepo);

  Future<DeleteAccountDto> deleteAccount() {
    return deleteAccountRepo.deleteAccount();
  }

  String getErrorMessage() {
    return deleteAccountRepo.getErrorMessage();
  }
}
