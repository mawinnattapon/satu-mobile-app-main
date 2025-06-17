import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final elavatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      foregroundColor: WidgetStateProperty.all(AppColor.light),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColor.primary.shade600.withOpacity(0.6);
        } else if (states.contains(WidgetState.pressed)) {
          return AppColor.primary.shade600;
        } else {
          return AppColor.primary.shade600;
        }
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColor.primary.shade700;
        } else if (states.contains(WidgetState.pressed)) {
          return AppColor.primary.shade700;
        } else {
          return AppColor.primary.shade800;
        }
      }),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
        vertical: 15,
      )),
    ),
  );
}
