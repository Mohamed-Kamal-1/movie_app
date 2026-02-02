import 'package:flutter/material.dart';

import '../../core/colors/app_color.dart';
import '../login_screen/login_screen.dart';
import '../login_screen/toogle_switch_widget.dart';

class RegisterBottomSection extends StatelessWidget {
  const RegisterBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  MaterialPageRoute(builder: (_) => LoginScreen()),
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
    );
  }
}
