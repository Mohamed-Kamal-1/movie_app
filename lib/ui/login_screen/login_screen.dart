import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/icons/app_icon.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../core/images/app_image.dart';
import '../../core/routes/app_routes.dart';
import 'toogle_switch_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 118,
                child: Image.asset(AppImage.loginLogo),
              ),
              const SizedBox(height: 60),
              ///////////////////////////-----------email-field----------//////////////////////
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
              const SizedBox(height: 20),
              //////////////////////-------------password_field------------//////////////////////
              TextField(
                style:  context.fonts.titleSmall,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: context.fonts.titleSmall,
                  filled: true,
                  fillColor: AppColor.gray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: SvgPicture.asset(AppImage.lock , fit: BoxFit.scaleDown,),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      ///////////////!!!!!!!!///////////////
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ///////////////////-----------Forgot-Password------------//////////////
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.ForgetScreen.name,
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: context.fonts.bodyMedium?.copyWith(color: AppColor.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ///////////////////-----------login-button------------//////////////
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.name);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.goldenYellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:  Text(
                  'Login',
                  style: context.fonts.titleMedium?.copyWith(color: AppColor.black),
                ),
              ),
              const SizedBox(height: 22),
              ///////////////////-----------Register------------//////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t Have Account ? ',
                    style: context.fonts.bodyMedium?.copyWith(color: AppColor.white)
                  ),
                  InkWell(
                    onTap: () {
                     Navigator.pushNamed(context, AppRoutes.RegisterScreen.name);
                    },
                    child: Text(
                      'Create One',
                      style: context.fonts.bodyMedium?.copyWith(color: AppColor.yellow),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),

              ///////////////////-----------OR------------//////////////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children:  [
                    Expanded(child: Divider(color: AppColor.yellow)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: context.fonts.bodyMedium?.copyWith(color: AppColor.yellow),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColor.yellow)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ///////////////////-----------login-with-google------------//////////////
              ElevatedButton.icon(
                onPressed: () {
                  /////////////////!!!!!!!!///////////////
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.goldenYellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: SvgPicture.asset(AppIcon.ic_google),
                label:  Text(
                  'Login With Google',
                  style: context.fonts.titleMedium?.copyWith(color: AppColor.black),
                ),
              ),
               SizedBox(height: 20,),
              ///////////////////-----------toogle------------//////////////
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 125.0),
                 child: LanguageSwitcher(),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
