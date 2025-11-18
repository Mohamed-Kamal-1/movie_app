import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/images/app_image.dart';


import '../OnBoarding/widgets/CutomFormField.dart';

class UpdateProfile extends StatefulWidget {
   UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int selectedAvatar = 0;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
            //  Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showBottomSheet(context, imgList),
              child: Image.asset(imgList[selectedAvatar], width: 150, height: 150),
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
              },
            ),

            SizedBox(height: 16),

            Text("reset password",
              style: Theme.of(context).textTheme.titleMedium,

            ),

            Spacer(),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Delete Account",style: Theme.of(context).textTheme.titleMedium,),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
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
    );
  }

  _showBottomSheet(BuildContext ctx, List<String> imgs ) {
    showModalBottomSheet(
      context: ctx,
        backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
            color: Color(0xFF282A28) ,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              )
            ),
            height: 400,
            width: double.infinity,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),

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
                          color: selectedAvatar == index ? AppColor.yellow : Colors.transparent  ,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.yellow)),
                        child: Image.asset(imgs[index], width: 86, height: 86)),
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
