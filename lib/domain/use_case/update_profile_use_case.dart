import 'package:injectable/injectable.dart';

import '../../api/model/profile/update_profile_dto.dart';
import '../repos/update_profile_repo.dart';

@injectable
class UpdateProfileUseCase {
  final UpdateProfileRepo updateProfileRepo;

  UpdateProfileUseCase(this.updateProfileRepo);

  Future<UpdateProfileDto> updateProfile(String email, int avatarId) {
    return updateProfileRepo.updateProfile(email, avatarId);
  }

  String getErrorMessage() {
    return updateProfileRepo.getErrorMessage();
  }
}
