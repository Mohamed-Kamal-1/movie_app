import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(),
    appBarTheme: AppBarTheme(),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColor.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColor.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: GoogleFonts.inter(
        color: AppColor.bluePrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      focusColor: AppColor.bluePrimaryColor,
      fillColor: Colors.transparent,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.gray, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),

      labelStyle: GoogleFonts.inter(
        color: AppColor.gray,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColor.gray,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColor.gray,
      suffixIconColor: AppColor.gray,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.bluePrimaryColor,
        foregroundColor: AppColor.whitePrimaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.bluePrimaryColor,
      selectedItemColor: AppColor.whitePrimaryColor,
      unselectedItemColor: AppColor.offWhite,
    ),
  );

  ////////////////////////////// Dark //////////////////////////////////////////////////
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColor.darkBluePrimaryColor,
      secondary: AppColor.bluePrimaryColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColor.darkBluePrimaryColor),
    scaffoldBackgroundColor: AppColor.darkBluePrimaryColor,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        color: AppColor.offWhite,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),

      headlineMedium: GoogleFonts.inter(
        color: AppColor.whitePrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled:true ,
      focusColor: AppColor.darkBluePrimaryColor,
      fillColor: Colors.transparent,

      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.darkBluePrimaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.bluePrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      activeIndicatorBorder:BorderSide(
        color: AppColor.bluePrimaryColor
      ) ,

      labelStyle: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(
        color: AppColor.offWhite,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: AppColor.offWhite,
      suffixIconColor: AppColor.offWhite,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.bluePrimaryColor,
        foregroundColor: AppColor.whitePrimaryColor,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkBluePrimaryColor,
      selectedItemColor: AppColor.whitePrimaryColor,
      unselectedItemColor: AppColor.offWhite,
    ),
  );
}
