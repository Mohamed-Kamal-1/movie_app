
import '../../../api/model/profile/profile_response_dto.dart';

abstract class ProfileScreenState {}
class ProfileInitialState extends ProfileScreenState {}
class ProfileLoadingState extends ProfileScreenState {}
class ProfileErrorState extends ProfileScreenState {
  String errorMessage;
  ProfileErrorState(this.errorMessage);
}
class ProfileSuccessState extends ProfileScreenState {
  ProfileResponseDto profile;
  ProfileSuccessState(this.profile);
}
