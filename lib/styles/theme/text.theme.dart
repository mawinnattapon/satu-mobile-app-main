import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satu/constants/app.colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextStyle text = TextStyle(
      fontFamily: GoogleFonts.kanit().fontFamily, color: AppColor.black);

  static TextTheme textTheme = TextTheme(
    bodyLarge: text.copyWith(fontSize: 16.0),
    bodyMedium: text.copyWith(fontSize: 16.0),
    displayLarge: text.copyWith(fontSize: 26.0, fontWeight: FontWeight.bold),
    displayMedium: text.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold),
    displaySmall: text.copyWith(fontSize: 22.0, fontWeight: FontWeight.bold),
    headlineMedium: text.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
    headlineSmall: text.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
    titleLarge: text.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
  );
}
