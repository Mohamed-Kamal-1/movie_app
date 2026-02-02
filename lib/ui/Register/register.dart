import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/Register/auth_input_section.dart';
import 'package:movie_app/ui/Register/avatar_section.dart';

import '../../core/di/di.dart';
import 'auth_cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(

            appBar: AppBar(title: const Text("Register"), centerTitle: true),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Column(
                  children: [
                    const AvatarSection(),
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
                const AuthInputSection(),
              ],
            ),
              ),
            ),
          ),
        );
  }
}
