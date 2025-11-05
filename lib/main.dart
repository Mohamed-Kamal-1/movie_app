import 'package:flutter/material.dart';
import 'package:movie_app/SharedPreferences/language_shared_preferences.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/ui/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/ui/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile.dart';
import 'package:movie_app/ui/forget_password_screen/forget_screen.dart';
import 'package:movie_app/ui/home_screen/home_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   theme:
      darkTheme: AppTheme.Theme,
      themeMode: ThemeMode.dark,
      //   locale: Locale(appLanguageProvider.getAppLanguage()),
      debugShowCheckedModeBanner: false,
      //   localizationsDelegates: AppLocalizations.localizationsDelegates,
      //   supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.OnBoardingScreen.name,
        routes: {
          AppRoutes.HomeScreen.name : (context) =>  HomeScreen(),
          AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
          AppRoutes.BasicOnBoarding.name: (context) => const BasicOnBoarding(),
          AppRoutes.UpdateProfile.name: (context) => UpdateProfile(),
          AppRoutes.LoginScreen.name: (context) =>  const LoginScreen(),
          AppRoutes.ForgetScreen.name: (context) =>  const ForgetScreen(),
          AppRoutes.RegisterScreen.name: (context) =>  const RegisterScreen(),
        },
    );
  }
}
