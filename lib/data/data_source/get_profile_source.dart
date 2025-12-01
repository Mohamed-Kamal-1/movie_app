import 'package:movie_app/api/model/profile/profile_response_dto.dart';

abstract interface class GetProfileSource {

  Future<ProfileResponseDto> getProfile();

  String getErrorMessage();

  String getErrorStatusCode();

}