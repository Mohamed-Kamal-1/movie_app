import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/extensions/extension.dart';
import '../../core/colors/app_color.dart';
import '../../core/images/app_image.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AppImage.forgetImage),
            SizedBox(height: 24,),
            TextField(
              style: context.fonts.titleSmall,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: context.fonts.titleSmall,
                filled: true,
                fillColor: AppColor.gray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: SvgPicture.asset(AppImage.emailIcon , fit: BoxFit.scaleDown,),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                /////////////////!!!!!!!!///////////////
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                backgroundColor: AppColor.yellow,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child:  Text(
                'Verify Email',
                style: context.fonts.titleMedium?.copyWith(color: AppColor.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
