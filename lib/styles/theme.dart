import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.size.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/styles/theme/elevated_theme.dart';
import 'package:satu/styles/theme/field_theme.dart';
import 'package:satu/styles/theme/outlined_theme.dart';
import 'package:satu/styles/theme/text.theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTextStyle.hsetStyle(colors: AppColor.white, size: 18, fontWeight: FontWeight.normal),
      iconTheme: const IconThemeData(color: AppColor.white),
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: TTextTheme.textTheme,
    primaryColor: AppColor.primary,
    primarySwatch: AppColor.primary,
    scaffoldBackgroundColor: AppColor.white,
    listTileTheme: ListTileThemeData(
      titleTextStyle: AppTextStyle.b2Style(),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    cardTheme: CardThemeData(
      shadowColor: AppColor.primary.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusDefault)),
      ),
    ),
    colorScheme: ThemeData().colorScheme.copyWith(primary: AppColor.primary, surface: AppColor.background),
    iconTheme: const IconThemeData(
      color: AppColor.primary,
    ),
    outlinedButtonTheme: TOutlineButtonTheme.outlineButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.elavatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.inputDecorationTheme,
  );
}
