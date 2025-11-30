import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/profile/profile_response_dto.dart';
import '../../data/data_source/get_profile_source.dart';
import '../api_manager.dart';

@Injectable(as: GetProfileSource)
class GetProfileDataSourceImpl implements  GetProfileSource {
  ApiManager apiManager;
  String? errorMessage;

  GetProfileDataSourceImpl(this.apiManager);

  @override
  String getErrorMessage() {
    return errorMessage ?? 'not Found';
  }

  @override
  String getErrorStatusCode() {
    return "200";
  }

  @override
  Future<ProfileResponseDto> getProfile() async {
    ProfileResponseDto res = await apiManager.getProfile();
    errorMessage = res.message;

    return res;
  }
}
