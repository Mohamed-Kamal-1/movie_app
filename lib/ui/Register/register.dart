import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/auth/presentation/auth_cubit/register_cubit.dart';
import 'package:movie_app/core/images/app_image.dart';
import '../../auth/presentation/auth_cubit/register_state.dart';
import '../../core/AppFromField.dart';
import '../../core/colors/app_color.dart';
import '../../core/di/di.dart';
import '../../core/validators.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/toogle_switch_widget.dart';

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
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),

      child: Scaffold(
        appBar: AppBar(title: Text("Register"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                                        backgroundImage: AssetImage(
                                          avatars[index],
                                        ),
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
                      ),
                      AppFormField(
                        controller: emailController,
                        label: "Email",
                        icon: SvgPicture.asset(
                          AppImage.email_icon,
                          width: 25,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text?.trim().isEmpty == true) {
                            return "Please enter your email";
                          }
                          if (!isValidEmail(text)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      AppFormField(
                        controller: passwordController,
                        label: "Password",
                        icon: SvgPicture.asset(
                          AppImage.password_icon,
                          width: 25,
                          height: 28,
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
                          return null;
                        },
                      ),
                      AppFormField(
                        controller: rePasswordController,
                        label: "Confirm Password",
                        icon: SvgPicture.asset(
                          AppImage.password_icon,
                          width: 25,
                          height: 28,
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
                          return null;
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
                          if (!isValidPhone(text)) {
                            return "Please enter valid Phone";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  /////////////////cubit/////////////////
                                  context.read<RegisterCubit>().register(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    confirmPassword: rePasswordController.text
                                        .trim(),
                                    phone: phoneController.text.trim(),
                                    avaterId:
                                        avatarController.page?.round() ?? 0,
                                  );
                                }
                              },
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
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have Account ? ",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: AppColor.goldenYellow),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 125.0),
                        child: LanguageSwitcher(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
