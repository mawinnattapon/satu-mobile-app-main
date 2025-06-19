import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle textprimary = TextStyle(
    color: AppColor.primary,
    fontFamily: 'SF Pro Text',
  );

  static TextStyle textwhite = TextStyle(
    color: AppColor.white,
    fontFamily: 'SF Pro Text',
  );

  static TextStyle textblack = TextStyle(
    color: AppColor.black,
    fontFamily: 'SF Pro Text',
  );

  static TextStyle textsecondary = TextStyle(
    color: AppColor.secondary,
    fontFamily: 'SF Pro Text',
  );

  static TextStyle textdart = TextStyle(
    color: AppColor.dark.shade300,
    fontFamily: 'SF Pro Text',
  );

  static TextStyle p1Style() => textprimary.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static TextStyle p2Style() => textprimary.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle p3Style() => textprimary.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  static TextStyle p4Style() => textprimary.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  static TextStyle d1Style() => textdart.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static TextStyle d2Style() => textdart.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle d3Style() => textdart.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  static TextStyle d4Style() => textdart.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  static TextStyle w1Style() => textwhite.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static TextStyle w2Style() => textwhite.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle w3Style() => textwhite.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  static TextStyle w4Style() => textwhite.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
  static TextStyle b1Style() => textblack.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static TextStyle b2Style() => textblack.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle b3Style() => textblack.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  static TextStyle b4Style() => textblack.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  static TextStyle s1Style() => textsecondary.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );

  static TextStyle s2Style() => textsecondary.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle s3Style() => textsecondary.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  static TextStyle s4Style() => textsecondary.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  static TextStyle hsetStyle(
          {required Color colors,
          required double size,
          required FontWeight fontWeight}) =>
      TextStyle(
        fontSize: size,
        color: colors,
        fontWeight: fontWeight,
      ).apply(
        fontFamily: 'SF Pro Text',
      );

  static TextStyle setStyle({required Color colors, required double size}) =>
      TextStyle(
        fontSize: size,
        color: colors,
      ).apply(
        fontFamily: 'SF Pro Text',
      );
}
