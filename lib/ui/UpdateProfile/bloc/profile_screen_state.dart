
import 'package:movie_app/domain/model/movie_model.dart';

import '../../../api/model/profile/profile_response_dto.dart';

abstract class ProfileScreenState {}
class ProfileInitialState extends ProfileScreenState {}
class ProfileLoadingState extends ProfileScreenState {}
class ProfileErrorState extends ProfileScreenState {
  Exception errorMessage;
  ProfileErrorState({required this.errorMessage});
}
class ProfileSuccessState extends ProfileScreenState {
  // ProfileResponseDto profile;
  String? name;
  ProfileSuccessState({required this.name});
}


class ProfileMoviesListLoaded extends ProfileScreenState {
  List<MovieModel>? list;
  ProfileMoviesListLoaded(this.list);
}
