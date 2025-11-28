import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/ui/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile_screen.dart';
import 'package:movie_app/ui/forget_password_screen/forget_screen.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'api/my_bloc_observer.dart';
import 'core/di/di.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  // WidgetsFlutterBinding.ensureInitialized();
  // await AppSharedPreferences.init();
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => LanguageProvider()),
    //   ],
    //   child: const MyApp(),
    // ),
    const MyApp(),
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
      initialRoute: AppRoutes.UserProfileScreen.name,
      routes: {
        AppRoutes.HomeTab.name: (context) => HomeTab(),
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.BasicOnBoarding.name: (context) => const BasicOnBoarding(),
        AppRoutes.UpdateProfile.name: (context) => UpdateProfileScreen(),
        AppRoutes.UserProfileScreen.name: (context) => UserProfileScreen(),
        AppRoutes.LoginScreen.name: (context) => const LoginScreen(),
        AppRoutes.ForgetScreen.name: (context) => const ForgetScreen(),
        AppRoutes.RegisterScreen.name: (context) => const RegisterScreen(),
      },
    );
  }
}
