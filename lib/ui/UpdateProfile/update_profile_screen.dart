import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_view_model.dart';
import 'package:movie_app/core/di/di.dart';  // for getIt

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileViewModel>()..getProfile(),
      child: const UpdateProfile(),
    );
  }
}
