
import 'package:movie_app/api/model/profile/profile_response_dto.dart';

abstract interface class ProfileRepo {
  Future<ProfileResponseDto> getProfile();
  String getErrorMessage();
}
