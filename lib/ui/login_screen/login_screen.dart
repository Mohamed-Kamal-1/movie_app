import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/AppFromField.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/extention/error_extention.dart';
import 'package:movie_app/core/validators.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../core/images/app_image.dart';
import '../../core/routes/app_routes.dart';
import 'login_bottom_section.dart';
import 'login_button.dart';
import 'login_state.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginViewModel _viewModel;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _loginFocus = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt.get<LoginViewModel>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _viewModel.close();
    super.dispose();
    _passwordFocus.dispose();
    _emailFocus.dispose();
    _debounce?.cancel();
    _loginFocus.dispose();
  }

  void _handleLogin() {
    if (formKey.currentState?.validate() ?? false) {
      _viewModel.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void changeFocusInput(String? text, FocusNode focusInput) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: 1500), () {
      if (!mounted) return;
      if (text != null && text
          .trim()
          .isNotEmpty) {
        FocusScope.of(context).requestFocus(focusInput);
      }
    });
  }

  void _handleGoogleLogin() {
    // _viewModel.loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _viewModel,
      child: BlocListener<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.HomeTab.name);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
  content: Text(context.getErrorMessage(state.errorMessage)),
                backgroundColor: AppColor.yellow,
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(19.0).copyWith(
                      top: 70
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 118,
                          child: Image.asset(AppImage.loginLogo),
                        ),
                        const SizedBox(height: 60),
                        AppFormField(
                          focusNode: _emailFocus,
                          onChange: (email) {
                            if (isValidEmail(email)) {
                              changeFocusInput(email, _passwordFocus);
                            }
                          },
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          icon: SvgPicture.asset(
                            AppImage.emailIcon,
                            fit: BoxFit.scaleDown,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!isValidEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        AppFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: _passwordFocus,
                          onChange: (password) {
                            if (password != null &&
                                password.length >= 6) {
                              changeFocusInput(password, _loginFocus);
                            }
                          },
                          label: 'Password',
                          controller: _passwordController,
                          isPassword: true,
                          icon: SvgPicture.asset(
                            AppImage.lock,
                            fit: BoxFit.scaleDown,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
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
                              style: context.fonts.bodyMedium?.copyWith(
                                color: AppColor.yellow,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        LoginButton(
                          handleLogin: _handleLogin,
                          loginFocus: _loginFocus,
                        ),
                        LoginBottomSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
