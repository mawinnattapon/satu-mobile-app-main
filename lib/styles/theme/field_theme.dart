import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.size.dart';
import 'package:satu/constants/app.textstyle.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    prefixIconColor: AppColor.primary,
    fillColor: Colors.white,
    alignLabelWithHint: true,
    filled: true,
    floatingLabelStyle:
        AppTextStyle.setStyle(colors: AppColor.primary.shade300, size: 16),
    hintStyle: AppTextStyle.setStyle(colors: Colors.black38, size: 16),
    labelStyle:
        AppTextStyle.setStyle(colors: AppColor.primary.shade300, size: 16),
    errorStyle:
        AppTextStyle.setStyle(colors: AppColor.danger.shade300, size: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusDefault),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColor.primary,
      ),
    ),
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusDefault),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColor.primary,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusDefault),
      borderSide: const BorderSide(color: AppColor.grey, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusDefault),
      borderSide: BorderSide(color: AppColor.danger.shade100, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.borderRadiusDefault),
      borderSide: BorderSide(color: AppColor.danger.shade100, width: 1.0),
    ),
  );
}
