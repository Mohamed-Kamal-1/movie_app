import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/ui/Register/register_bottom_section.dart';

import '../../core/AppFromField.dart';
import '../../core/colors/app_color.dart';
import '../../core/extention/error_extention.dart';
import '../../core/images/app_image.dart';
import '../../core/validators.dart';
import '../login_screen/login_screen.dart';

import 'auth_cubit/register_cubit.dart';
import 'auth_cubit/register_state.dart';

class AuthInputSection extends StatefulWidget {
  const AuthInputSection({super.key});

  @override
  State<AuthInputSection> createState() => _AuthInputSectionState();
}

class _AuthInputSectionState extends State<AuthInputSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late RegisterCubit cubit;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _rePasswordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _createAccountFocus = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    cubit = getIt.get<RegisterCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _rePasswordFocus.dispose();
    _phoneFocus.dispose();
    _createAccountFocus.dispose();
  }

  void changeFocusInput(String? text, FocusNode focusInput) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: 1500), () {
      if (!mounted) return;
      if (text != null && text.trim().isNotEmpty) {
        FocusScope.of(context).requestFocus(focusInput);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            SnackBar(
              content: Text(context.getErrorMessage(state.message)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },

      builder: (context, state) {
        bool isLoading = state is LoadingState;
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFormField(
                onChange: (text) {
                  changeFocusInput(text, _emailFocus);
                },
                controller: nameController,
                label: "Name",
                icon: SvgPicture.asset(AppImage.profile_icon),
                validator: (text) => (text?.trim().isEmpty ?? true)
                    ? "Please enter your name"
                    : null,
              ),
              AppFormField(
                focusNode: _emailFocus,
                controller: emailController,
                label: "Email",
                onChange: (email) {
                  if (isValidEmail(email)) {
                    changeFocusInput(email, _passwordFocus);
                  } else {
                    _debounce?.cancel();
                  }
                },

                icon: SvgPicture.asset(AppImage.email_icon),
                validator: (text) {
                  if (text?.trim().isEmpty ?? true) {
                    return "Enter email";
                  }
                  if (!isValidEmail(text)) return "Invalid email";
                  return null;
                },
              ),
              AppFormField(
                controller: passwordController,
                focusNode: _passwordFocus,

                label: "Password",
                isPassword: true,
                icon: SvgPicture.asset(AppImage.password_icon),
                validator: (text) {
                  if (text?.trim().isEmpty ?? true) {
                    return "Enter password";
                  }
                  if ((text?.length ?? 0) < 6) return "Min 6 chars";
                  return null;
                },
                onChange: (password) {
                  if ((password?.length ?? 0) > 6 &&
                      password != null &&
                      password.trim().isNotEmpty) {}
                  changeFocusInput(password, _rePasswordFocus);
                },
                textInputAction: TextInputAction.newline,
              ),
              AppFormField(
                focusNode: _rePasswordFocus,

                controller: rePasswordController,
                label: "Confirm Password",
                isPassword: true,
                icon: SvgPicture.asset(AppImage.password_icon),
                validator: (text) => text != passwordController.text
                    ? "Passwords don't match"
                    : null,
                onChange: (text) {
                  if (passwordController.text == rePasswordController.text) {
                    changeFocusInput(text, _phoneFocus);
                  }
                },
              ),
              AppFormField(
                focusNode: _phoneFocus,
                controller: phoneController,
                onChange: (phone) {
                  if (isValidPhone(phone)) {
                    changeFocusInput(phone, _createAccountFocus);
                  }
                },
                label: "Phone",
                icon: SvgPicture.asset(AppImage.phone_icon),
                validator: (text) =>
                    !isValidPhone(text) ? "Invalid phone" : null,
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                focusNode: _createAccountFocus,
                onPressed: isLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          cubit.register(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            confirmPassword: rePasswordController.text.trim(),
                            phone: phoneController.text.trim(),
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
              const RegisterBottomSection(),
            ],
          ),
        );
      },
    );
  }
}
