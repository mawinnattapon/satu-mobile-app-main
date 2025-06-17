import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';

class TOutlineButtonTheme {
  TOutlineButtonTheme._();

  static final outlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      disabledForegroundColor: AppColor.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: AppColor.primary,
      side: const BorderSide(color: AppColor.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
    ),
  );
}
