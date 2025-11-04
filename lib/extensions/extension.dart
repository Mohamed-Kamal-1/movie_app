import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  TextTheme get fonts => Theme.of(this).textTheme;
  BottomNavigationBarThemeData get bottomNavBarTheme =>
      Theme.of(this).bottomNavigationBarTheme;
}
