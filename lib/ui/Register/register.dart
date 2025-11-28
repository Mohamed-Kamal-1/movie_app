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
import '../login_screen/login_screen.dart';
import '../login_screen/toogle_switch_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: const RegisterScreenContent(),
    );
  }
}

class RegisterScreenContent extends StatefulWidget {
  const RegisterScreenContent({super.key});

  @override
  State<RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<RegisterScreenContent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final PageController avatarController = PageController(
    viewportFraction: 0.33,
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> avatars = [
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
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        }

        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },

      builder: (context, state) {
        bool isLoading = state is LoadingState;

        return Scaffold(
          appBar: AppBar(title: const Text("Register"), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// ------- AVATAR --------
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
                                  onTap: () => avatarController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  ),
                                  child: CircleAvatar(
                                    radius: 47 + (80 - 47) * value,
                                    backgroundImage: AssetImage(avatars[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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

                  /// ------- FORM --------
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppFormField(
                          controller: nameController,
                          label: "Name",
                          icon: SvgPicture.asset(AppImage.profile_icon),
                          validator: (text) => (text?.trim().isEmpty ?? true)
                              ? "Please enter your name"
                              : null,
                        ),
                        AppFormField(
                          controller: emailController,
                          label: "Email",
                          icon: SvgPicture.asset(AppImage.email_icon),
                          validator: (text) {
                            if (text?.trim().isEmpty ?? true)
                              return "Enter email";
                            if (!isValidEmail(text)) return "Invalid email";
                            return null;
                          },
                        ),
                        AppFormField(
                          controller: passwordController,
                          label: "Password",
                          isPassword: true,
                          icon: SvgPicture.asset(AppImage.password_icon),
                          validator: (text) {
                            if (text?.trim().isEmpty ?? true)
                              return "Enter password";
                            if ((text?.length ?? 0) < 6) return "Min 6 chars";
                            return null;
                          },
                        ),
                        AppFormField(
                          controller: rePasswordController,
                          label: "Confirm Password",
                          isPassword: true,
                          icon: SvgPicture.asset(AppImage.password_icon),
                          validator: (text) => text != passwordController.text
                              ? "Passwords don't match"
                              : null,
                        ),
                        AppFormField(
                          controller: phoneController,
                          label: "Phone",
                          icon: SvgPicture.asset(AppImage.phone_icon),
                          validator: (text) =>
                              !isValidPhone(text) ? "Invalid phone" : null,
                        ),

                        const SizedBox(height: 16),

                        /// ------- BUTTON -------
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.register(
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
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Create Account"),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: AppColor.goldenYellow),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: LanguageSwitcher(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
