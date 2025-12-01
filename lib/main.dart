import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/presentation/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/presentation/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/profile_tab/profile.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile_screen.dart';
import 'package:movie_app/ui/forget_password_screen/forget_screen.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'api/my_bloc_observer.dart';
import 'bloc/language_provider.dart';
import 'package:provider/provider.dart';
import 'core/di/di.dart';
import 'package:movie_app/SharedPreferences/language_shared_preferences.dart';



void main() async {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
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
        AppRoutes.HomeTab.name: (context) => HomeTab(),
        AppRoutes.ProfileTab.name: (context) => ProfileTab(),
        AppRoutes.OnBoardingScreen.name: (context) => const OnBoardingScreen(),
        AppRoutes.BasicOnBoarding.name: (context) => const BasicOnBoarding(),
        AppRoutes.UpdateProfile.name: (context) => UpdateProfileScreen(),
        AppRoutes.UserProfileScreen.name: (context) => UserProfileScreen(),
        AppRoutes.LoginScreen.name: (context) => const LoginScreen(),
        AppRoutes.ForgetScreen.name: (context) => const ForgetScreen(),
        AppRoutes.RegisterScreen.name: (context) => const RegisterScreen(),
        AppRoutes.DetailsScreen.name: (context) => const DetailsScreen(),
      },
    );
  }
}
