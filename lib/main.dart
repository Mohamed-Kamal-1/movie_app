import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/extention/update_app.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/presentation/OnBoarding/basic_on_boarding.dart';
import 'package:movie_app/presentation/OnBoarding/on_boarding_screen.dart';
import 'package:movie_app/presentation/initial_route.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/Register/register.dart';
import 'package:movie_app/ui/UpdateProfile/update_profile_screen.dart';
import 'package:movie_app/ui/forget_password_screen/forget_screen.dart';
import 'package:movie_app/ui/login_screen/login_screen.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import 'SharedPreferences/auth_shared_preferences.dart';
import 'SharedPreferences/language_shared_preferences.dart';
import 'api/my_bloc_observer.dart';
import 'bloc/language_provider.dart';
import 'core/di/di.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await AppSharedPreferences.init();
  await AuthSharedPreferences.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final ShorebirdUpdater updater = ShorebirdUpdater();

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    // Check whether a new update is available.
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        await updater.update();

        if (mounted) {
          context.showMessageUpdate();
        }
      } on UpdateException catch (error) {
        debugPrint("Shorebird Error: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: AppTheme.Theme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.InitialRoute.name,
      routes: {
        AppRoutes.HomeTab.name: (context) => const HomeTab(),
        AppRoutes.InitialRoute.name: (context) => const InitialRoute(),
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
