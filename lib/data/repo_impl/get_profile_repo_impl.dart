
import 'package:movie_app/api/model/profile/profile_response_dto.dart';
import 'package:movie_app/data/data_source/get_profile_source.dart';
import 'package:movie_app/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';


@Injectable(as : ProfileRepo)
class GetProfileRepoImpl implements ProfileRepo {

  final GetProfileSource getProfileSource;

  GetProfileRepoImpl(this.getProfileSource);

  @override
  String getErrorMessage() {
    return getProfileSource.getErrorMessage();
  }

  @override
  Future<ProfileResponseDto> getProfile() async {
      return await getProfileSource.getProfile();
  }
}