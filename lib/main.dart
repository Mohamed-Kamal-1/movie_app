import 'package:flutter/material.dart';
import 'package:movie_app/core/app_theme/app_theme.dart';
import 'package:movie_app/core/routes/app_routes.dart';
import 'package:movie_app/ui/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   theme:
        darkTheme: AppTheme.darkTheme,
        themeMode:ThemeMode.dark,
      //   locale: Locale(appLanguageProvider.getAppLanguage()),
        debugShowCheckedModeBanner: false,
      //   localizationsDelegates: AppLocalizations.localizationsDelegates,
      //   supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.HomeScreen.name,
        routes: {
          AppRoutes.HomeScreen.name : (context) =>  HomeScreen(),
        },
    );
  }
}
