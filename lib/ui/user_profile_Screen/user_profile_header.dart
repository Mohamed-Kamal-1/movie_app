import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile.dart';
import '../../core/di/di.dart';
import '../../core/images/app_image.dart';
import '../UpdateProfile/bloc/profile_view_model.dart';
import '../UpdateProfile/update_profile_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileViewModel>()..getProfile(),
      child: Container(
        decoration: BoxDecoration(color: AppColor.whiteGrey),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ClipOval(
                          child:
                              BlocBuilder<ProfileViewModel, ProfileScreenState>(
                                builder: (context, state) {
                                  int avatarId = 0;

                                  switch (state) {
                                    case ProfileSuccessState():
                                      avatarId =
                                          state.profile.data?.avaterId ?? 0;
                                      return Image.asset(
                                        imgList[avatarId],
                                        width: 118,
                                        height: 118,
                                        fit: BoxFit.cover,
                                      );

                                    case _:
                                      return Image.asset(
                                        AppImage.avatar_1,
                                        width: 118,
                                        height: 118,
                                        fit: BoxFit.cover,
                                      );
                                  }
                                },
                              ),
                        ),
                        SizedBox(height: 20),
                        BlocBuilder<ProfileViewModel, ProfileScreenState>(
                          builder: (context, state) {
                            String? name;
                            switch (state) {
                              case ProfileSuccessState():
                                name = state.profile.data?.name;
                              case _:
                                name = null;
                            }

                            return FittedBox(
                              child: Text(
                                name ?? "unKnown",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "12",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Wish List",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "10",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "History",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 33),

              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateProfileScreen();
                            },
                          ),
                        );
                      },
                      child: Text("Edit profile"),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          AppRoutes.LoginScreen.name,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exit",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const Icon(Icons.exit_to_app_outlined,size: 24,color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
