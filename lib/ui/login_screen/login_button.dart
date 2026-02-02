import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors/app_color.dart';
import '../../extensions/extension.dart';
import 'login_state.dart';
import 'login_view_model.dart';

typedef HandleLogin = void Function();

class LoginButton extends StatelessWidget {
  final HandleLogin handleLogin;
  final FocusNode loginFocus;

  const LoginButton({
    super.key,
    required this.handleLogin,
    required this.loginFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<LoginViewModel, LoginState>(
          builder: (context, state) {
            final isLoading = state is LoginLoadingState;
            return ElevatedButton(
              focusNode: loginFocus,
              onPressed: isLoading ? null : handleLogin,
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
                          AppColor.goldenYellow,
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
      ],
    );
  }
}
