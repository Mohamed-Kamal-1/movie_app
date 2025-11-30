import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/AppFromField.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/icons/app_icon.dart';
import 'package:movie_app/core/validators.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../core/images/app_image.dart';
import '../../core/routes/app_routes.dart';
import 'login_state.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginViewModel _viewModel;

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
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _viewModel.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _handleGoogleLogin() {
    _viewModel.loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>.value(
      value: _viewModel,
      child: BlocListener<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.HomeTab.name);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Login failed'),
                backgroundColor: AppColor.yellow,
              ),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Form(
                key: _formKey,
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
                    BlocBuilder<LoginViewModel, LoginState>(
                      builder: (context, state) {
                        final isLoading = state is LoginLoadingState;
                        return ElevatedButton(
                          onPressed: isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.goldenYellow,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.black,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Login',
                                  style: context.fonts.titleMedium?.copyWith(
                                    color: AppColor.black,
                                  ),
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t Have Account ? ',
                          style: context.fonts.bodyMedium?.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.RegisterScreen.name,
                            );
                          },
                          child: Text(
                            'Create One',
                            style: context.fonts.bodyMedium?.copyWith(
                              color: AppColor.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: AppColor.yellow)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: context.fonts.bodyMedium?.copyWith(
                                color: AppColor.yellow,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColor.yellow)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<LoginViewModel, LoginState>(
                      builder: (context, state) {
                        final isLoading = state is LoginLoadingState;
                        return ElevatedButton.icon(
                          onPressed: isLoading ? null : _handleGoogleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.goldenYellow,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: SvgPicture.asset(AppIcon.ic_google),
                          label: Text(
                            'Login With Google',
                            style: context.fonts.titleMedium?.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
