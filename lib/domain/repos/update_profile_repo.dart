import 'package:movie_app/api/model/profile/update_profile_dto.dart';


abstract interface class UpdateProfileRepo {

  Future<UpdateProfileDto> updateProfile(String email , int avatarId);
  String getErrorMessage();
}