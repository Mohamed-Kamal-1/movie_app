import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';

class AppTheme {
  static ThemeData Theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.black,
      foregroundColor: AppColor.yellow,
    ),
    scaffoldBackgroundColor: AppColor.black,

    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColor.yellow,
      cursorColor: AppColor.yellow,
      selectionHandleColor: AppColor.yellow,
    ),

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.inter(
        fontSize: 36,
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      ),

      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.white,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColor.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: GoogleFonts.inter(
        color: AppColor.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      // focusColor: AppColor.darkBluePrimaryColor,
      fillColor: Colors.transparent,

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          // color: AppColor.darkBluePrimaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        // borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      activeIndicatorBorder: BorderSide(
        // color: AppColor.bluePrimaryColor
      ),

      labelStyle: GoogleFonts.inter(
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColor.offWhite,
      suffixIconColor: AppColor.offWhite,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.goldenYellow,
        // foregroundColor: AppColor.whitePrimaryColor,
        textStyle: TextStyle(
          color: AppColor.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.gray,

      selectedItemColor: AppColor.yellow,
      unselectedItemColor: AppColor.white,
    ),
  );
}
