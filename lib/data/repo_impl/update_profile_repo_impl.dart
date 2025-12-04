import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/update_profile_dto.dart';
import 'package:movie_app/domain/repos/update_profile_repo.dart';

import '../data_source/update_profile_source.dart';


@Injectable(as : UpdateProfileRepo)
class UpdateProfileRepoImpl implements UpdateProfileRepo {


  final UpdateProfileSource updateProfileSource;

  UpdateProfileRepoImpl(this.updateProfileSource);

  @override
  String getErrorMessage() {
    return updateProfileSource.getErrorMessage();
  }

  @override
  Future<UpdateProfileDto> updateProfile(String email, int avatarId) async {
    return await updateProfileSource.updateProfile(email, avatarId);
  }


}