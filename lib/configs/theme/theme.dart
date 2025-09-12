import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constrants/app_color.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColor.backgroundLightColor,
    primaryColor: AppColor.primaryLightColor,
    secondaryHeaderColor: AppColor.secondaryLightColor,
    disabledColor: Colors.grey.withValues(alpha: 0.5),
    dividerColor: AppColor.dividerLightColor,
    cardColor: AppColor.cardLightColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: GoogleFonts.battambang(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.titleTextAppbarLightColor,
      ),
      backgroundColor: AppColor.primaryLightColor,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 1.5,
      shadowColor: Colors.black12,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.textLightColor,
      ),
      titleMedium: GoogleFonts.battambang(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColor.textLightColor,
      ),
      titleSmall: GoogleFonts.battambang(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColor.textLightColor,
      ),
      displayLarge: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColor.textLightColor,
      ),
      displayMedium: GoogleFonts.battambang(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.textLightColor,
      ),
      displaySmall: GoogleFonts.battambang(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.textLightColor,
      ),
      bodyLarge: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextLightColor,
      ),
      bodyMedium: GoogleFonts.battambang(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextLightColor,
      ),
      bodySmall: GoogleFonts.battambang(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.subTextLightColor,
      ),
      headlineLarge: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColor.textWhiteWhenLightColor,
      ),
      headlineMedium: GoogleFonts.battambang(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColor.textWhiteWhenLightColor,
      ),
      headlineSmall: GoogleFonts.battambang(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColor.textWhiteWhenLightColor,
      ),
      labelLarge: GoogleFonts.battambang(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryLightColor,
      ),
      labelMedium: GoogleFonts.battambang(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryLightColor,
      ),
      labelSmall: GoogleFonts.battambang(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColor.primaryLightColor,
      ),
    ),
    // using for alert & popup
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      primary: AppColor.primaryLightColor,
      onPrimary: Colors.white,
      secondary: AppColor.secondaryLightColor,
      onSecondary: AppColor.secondaryLightColor,
      error: Colors.black,
      onError: Colors.white,
      surface: const Color(0xfffbfbfb),
      primaryContainer: Colors.black,
      onSurface: Colors.black,
      brightness: Brightness.light,
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  );
}
