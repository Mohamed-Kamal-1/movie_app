import 'package:flutter/material.dart';
import 'package:movie_app/l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  TextTheme get fonts => Theme.of(this).textTheme;
  BottomNavigationBarThemeData get bottomNavBarTheme =>
      Theme.of(this).bottomNavigationBarTheme;
  AppLocalizations get appLocal => AppLocalizations.of(this)!;
}
