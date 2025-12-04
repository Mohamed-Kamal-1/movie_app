
import 'package:injectable/injectable.dart';

import '../../api/model/profile/profile_response_dto.dart';
import '../repos/profile_repo.dart';

@injectable
class ProfileUseCase {

  final ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);

  Future<ProfileResponseDto> getProfile() {
    return profileRepo.getProfile();
  }

  String getErrorMessage() {
    return profileRepo.getErrorMessage();
  }
}