import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/images/app_image.dart';
import '../../core/AppFromField.dart';
//import '../../core/Validator.dart';
import '../../core/colors/app_color.dart';
import '../../core/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  PageController avatarController = PageController(viewportFraction: 0.33);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<String> avatars = [
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

  @override
  void dispose() {
    avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 120,
                  child: PageView.builder(
                    controller: avatarController,
                    itemCount: avatars.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: avatarController,
                        builder: (context, child) {
                          double value = 1.0;

                          if (avatarController.position.haveDimensions) {
                            value = (avatarController.page! - index).abs();
                            value = (1 - (value * 0.5)).clamp(0.5, 1.6);
                          }

                          return Center(
                            child: Transform.scale(
                              scale: value,
                              child: GestureDetector(
                                onTap: () {
                                  avatarController.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 47 + (80 - 47) * value,
                                  child: CircleAvatar(
                                    radius: 47 + (80 - 47) * value,
                                    backgroundImage: AssetImage(avatars[index]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Avatar",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppFormField(
                    controller: nameController,
                    label: "Name",
                    icon: SvgPicture.asset(
                      AppImage.profile_icon,
                      width: 32.84,
                      height: 27.58,
                      fit: BoxFit.contain,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ), //remove
                  AppFormField(
                    controller: emailController,
                    label: "Email",
                    icon: SvgPicture.asset(
                      AppImage.email_icon,
                      width: 31,
                      height: 31,
                      fit: BoxFit.contain,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "Please enter your email";
                      }
                      // if (!isValidEmail(text)) {
                      //   return "Please enter valid email";
                      // }
                    },
                  ),
                  AppFormField(
                    controller: passwordController,
                    label: "Password",
                    icon: SvgPicture.asset(
                      AppImage.password_icon,
                      width: 25,
                      height: 31,
                      fit: BoxFit.contain,
                    ),
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "please enter password";
                      }
                      if ((text?.length ?? 0) < 6) {
                        return "Password must be at least 6 characters";
                      }
                    },
                  ),
                  AppFormField(
                    controller: rePasswordController,
                    label: "Confirm Password",
                    icon: SvgPicture.asset(
                      AppImage.password_icon,
                      width: 25,
                      height: 31,
                      fit: BoxFit.contain,
                    ),
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "please enter password";
                      }
                      if (passwordController.text != text) {
                        return "Password does not match";
                      }
                    },
                  ),
                  AppFormField(
                    controller: phoneController,
                    label: "Phone Number",
                    icon: SvgPicture.asset(
                      AppImage.phone_icon,
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (text) {
                      if (text?.trim().isEmpty == true) {
                        return "Please enter your phone number";
                      }
                      // if (!isValidPhone(text)) {
                      //   return "Please enter valid Phone";
                      // }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    /*isLoading
                        ? null
                        : () {
                      createAccount();
                    },*/
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.goldenYellow,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: GoogleFonts.inter(fontSize: 20),
                    ),
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 8),
                              Text("Loading..."),
                            ],
                          )
                        : Text("Create Account"),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have Account ? ",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.LoginScreen.name,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: AppColor.goldenYellow),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*void createAccount() async {
  if (validateForm() == false) {
    return;
  }
  setState(() {
    isLoading = true;
  });

  AppAuthProvider provider = Provider.of<AppAuthProvider>(
    context,
    listen: false,
  );

  AuthResponse response = await provider.register(
    emailController.text,
    passwordController.text,
    nameController.text,
  );

  if (response.success) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("User created successfully")));
    Navigator.pushReplacementNamed(context, AppRoutes.HomeScreen.route);
  } else {
    handleAuthError(response);
  }
  setState(() {
    isLoading = false;
  });
}*/
