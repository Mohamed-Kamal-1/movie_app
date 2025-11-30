import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/update_profile_dto.dart';
import 'package:movie_app/data/data_source/update_profile_source.dart';

import '../api_manager.dart';

@Injectable(as: UpdateProfileSource)
class UpdateProfileSourceImpl implements UpdateProfileSource {
  ApiManager apiManager;
  String? errorMessage;

  UpdateProfileSourceImpl(this.apiManager);

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
  Future<UpdateProfileDto> updateProfile(String email, int avatarId) async {
    final res = await apiManager.updateProfile(email, avatarId);
    return res;
  }
}
