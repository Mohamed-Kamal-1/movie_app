import 'package:flutter/material.dart';

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
      //   darkTheme:
      //   themeMode:,
      //   locale: Locale(appLanguageProvider.getAppLanguage()),
        debugShowCheckedModeBanner: false,
      //   localizationsDelegates: AppLocalizations.localizationsDelegates,
      //   supportedLocales: AppLocalizations.supportedLocales,
      //   initialRoute:
      //   routes: {
      //
      //   },
    );
  }
}
