import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import '../../core/images/app_image.dart';
import '../UpdateProfile/update_profile_screen.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.whiteGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipOval(
                      child:
                      // Image.asset(imgList[selectedAvatar], width: 150, height: 150),
                      Image.asset(
                        AppImage.avatar_1,
                        width: 118,
                        height: 118,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Mohamed",
                      style: Theme.of(context).textTheme.headlineSmall,),
                  ],
                ),

                Column(
                  children: [
                    Text("12",
                      style: Theme.of(context).textTheme.headlineSmall,),
                    SizedBox(height: 20),
                    Text("Wish List",
                      style: Theme.of(context).textTheme.headlineSmall,),
                  ],
                ),
                Column(
                  children: [Text("10",
                    style: Theme.of(context).textTheme.headlineSmall,),
                    SizedBox(height: 20),
                    Text("History",
                      style: Theme.of(context).textTheme.headlineSmall,)],
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
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

                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.red,
                        ),
                        child: Text("Exit",
                      style: Theme.of(context).textTheme.titleSmall,))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
