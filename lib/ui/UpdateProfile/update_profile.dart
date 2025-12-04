import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/ui/UpdateProfile/bloc/profile_screen_state.dart';

import '../../core/di/di.dart';
import 'bloc/profile_view_model.dart';
import 'widget/CutomFormField.dart';

final imgList = [
  AppImage.avatar_1,
  AppImage.avatar_2,
  AppImage.avatar_3,
  AppImage.avatar_4,
  AppImage.avatar_5,
  AppImage.avatar_6,
  AppImage.avatar_7,
  AppImage.avatar_8,
  AppImage.avatar_9,
];

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int selectedAvatar = -1;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileScreenState>(
      builder: (context, state) {
        switch (state) {
          case ProfileSuccessState():
            final rawId = state.profile.data?.avaterId ?? 0;
            final profileAvatarId = (rawId >= 0 && rawId < imgList.length)
                ? rawId
                : 0;
            final profileEmail = state.profile.data?.email ?? '';
            final profilePhone = state.profile.data?.phone ?? '';
            if (nameController.text != profileEmail) {
              nameController.text = profileEmail;
            }
            if (phoneController.text != profilePhone) {
              phoneController.text = profilePhone;
            }
            final displayedAvatarIndex =
                (selectedAvatar >= 0 && selectedAvatar < imgList.length)
                ? selectedAvatar
                : profileAvatarId;

            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Center(
                  child: Text(
                    "Pick Avatar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.goldenYellow,
                    ),
                  ),
                ),
                leading: IconButton(
                  color: AppColor.goldenYellow,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _showBottomSheet(context, imgList),
                        child: Image.asset(
                          imgList[displayedAvatarIndex],
                          width: 150,
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 16),
                      AppFormField(
                        controller: nameController,
                        label: "Name",
                        hint: "name",
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (text) {
                          if (text?.trim().isEmpty == true) {
                            return "Please enter Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      AppFormField(
                        controller: phoneController,
                        label: "phone",
                        icon: Icons.phone,
                        hint: "phone number",
                        keyboardType: TextInputType.phone,
                        validator: (text) {
                          if (text?.trim().isEmpty == true) {
                            return "Please enter phone number";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),

                      Text(
                        "reset password",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                getIt<ProfileViewModel>().deleteAcc();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                "Delete Account",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final avatarToSend = (selectedAvatar >= 0)
                                    ? selectedAvatar
                                    : profileAvatarId;
                                getIt<ProfileViewModel>().updateData(
                                  nameController.text,
                                  avatarToSend,
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Update Data",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            );

          case ProfileErrorState():
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
            );

          case ProfileInitialState():
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            );

          case ProfileLoadingState():
            return Container(
              color: Colors.black,
              child: Center(child: CircularProgressIndicator()),
            );
        }
        return SizedBox.shrink();
      },
    );
  }

  _showBottomSheet(BuildContext ctx, List<String> imgs) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.gray,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            height: 400,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),

              itemCount: imgs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAvatar = index;
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      height: 108,
                      width: 105,
                      decoration: BoxDecoration(
                        color: selectedAvatar == index
                            ? AppColor.yellow
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.yellow),
                      ),
                      child: Image.asset(imgs[index], width: 86, height: 86),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
