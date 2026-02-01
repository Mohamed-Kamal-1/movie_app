// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:movie_app/core/di/di.dart';
//
// import '../../auth/presentation/auth_cubit/register_cubit.dart';
// import '../../auth/presentation/auth_cubit/register_state.dart';
// import '../../core/AppFromField.dart';
// import '../../core/colors/app_color.dart';
// import '../../core/extention/error_extention.dart';
// import '../../core/images/app_image.dart';
// import '../../core/validators.dart';
// import '../login_screen/login_screen.dart';
// import '../login_screen/toogle_switch_widget.dart';
//
// class AuthInputSection extends StatefulWidget {
//   const AuthInputSection({super.key});
//
//   @override
//   State<AuthInputSection> createState() => _AuthInputSectionState();
// }
//
// class _AuthInputSectionState extends State<AuthInputSection> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController rePasswordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   late RegisterCubit cubit;
//
//   @override
//   void initState() {
//     super.initState();
//     cubit = getIt.get<RegisterCubit>();
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     rePasswordController.dispose();
//     phoneController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<RegisterCubit, RegisterState>(
//       listener: (context, state) {
//         if (state is SuccessState) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => LoginScreen()),
//           );
//         }
//
//         if (state is ErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(context.getErrorMessage(state.message)),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//
//       builder: (context, state) {
//         bool isLoading = state is LoadingState;
//         return Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               AppFormField(
//                 controller: nameController,
//                 label: "Name",
//                 icon: SvgPicture.asset(AppImage.profile_icon),
//                 validator: (text) => (text?.trim().isEmpty ?? true)
//                     ? "Please enter your name"
//                     : null,
//               ),
//               AppFormField(
//                 controller: emailController,
//                 label: "Email",
//                 icon: SvgPicture.asset(AppImage.email_icon),
//                 validator: (text) {
//                   if (text?.trim().isEmpty ?? true) {
//                     return "Enter email";
//                   }
//                   if (!isValidEmail(text)) return "Invalid email";
//                   return null;
//                 },
//               ),
//               AppFormField(
//                 controller: passwordController,
//                 label: "Password",
//                 isPassword: true,
//                 icon: SvgPicture.asset(AppImage.password_icon),
//                 validator: (text) {
//                   if (text?.trim().isEmpty ?? true) {
//                     return "Enter password";
//                   }
//                   if ((text?.length ?? 0) < 6) return "Min 6 chars";
//                   return null;
//                 },
//               ),
//               AppFormField(
//                 controller: rePasswordController,
//                 label: "Confirm Password",
//                 isPassword: true,
//                 icon: SvgPicture.asset(AppImage.password_icon),
//                 validator: (text) => text != passwordController.text
//                     ? "Passwords don't match"
//                     : null,
//               ),
//               AppFormField(
//                 controller: phoneController,
//                 label: "Phone",
//                 icon: SvgPicture.asset(AppImage.phone_icon),
//                 validator: (text) =>
//                     !isValidPhone(text) ? "Invalid phone" : null,
//               ),
//
//               const SizedBox(height: 16),
//
//               /// ------- BUTTON -------
//               ElevatedButton(
//                 onPressed: isLoading
//                     ? null
//                     : () {
//                         if (formKey.currentState!.validate()) {
//                           cubit.register(
//                             name: nameController.text.trim(),
//                             email: emailController.text.trim(),
//                             password: passwordController.text.trim(),
//                             confirmPassword: rePasswordController.text.trim(),
//                             phone: phoneController.text.trim(),
//                           );
//                         }
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColor.goldenYellow,
//                   foregroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text("Create Account"),
//               ),
//
//               const SizedBox(height: 10),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have account?",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => LoginScreen()),
//                       );
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(color: AppColor.goldenYellow),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 120),
//                 child: LanguageSwitcher(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
