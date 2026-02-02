import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/colors/app_color.dart';
import '../../core/icons/app_icon.dart';
import '../../core/routes/app_routes.dart';
import '../../extensions/extension.dart';
import 'login_state.dart';
import 'login_view_model.dart';

class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t Have Account ? ',
              style: context.fonts.bodyMedium?.copyWith(color: AppColor.white),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.RegisterScreen.name);
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
              onPressed: () {},
              // onPressed: isLoading ? null : _handleGoogleLogin,
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
    );
  }
}
