import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/layout/layout.dialog.dart';
import 'package:satu/library/button.dart';

class AppModal {
  AppModal._();

  static void alert({
    String title = "",
    Function()? onThan,
  }) {
    Get.dialog(LayoutDialog(
      height: 30.h,
      title: title,
      titleHeader: "error",
      icons: Icons.warning_rounded,
    )).then((value) {
      if (onThan != null) {
        onThan();
      }
    });
  }

  static void succfu({
    String title = "",
    String header = "Save as Draft",
    Function()? onThan,
  }) {
    Get.dialog(LayoutDialog(
      height: 30.h,
      title: title,
      titleHeader: header,
      icons: Icons.check_circle,
    )).then((value) {
      if (onThan != null) {
        onThan();
      }
    });
  }

  static Future<bool?> confirm(
    String title,
    String message, {
    String confirm = "OK",
    String cancel = "Cancel",
  }) async {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: AppColor.light,
        actionsAlignment: MainAxisAlignment.end,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        actionsPadding: const EdgeInsets.all(16),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        actions: [
          ButtonOutline(
            child: Text(cancel, style: const TextStyle(height: 0.5)),
            onPressed: () => Get.back(result: false),
          ),
          Button(
            child: Text(confirm, style: const TextStyle(height: 0.5)),
            onPressed: () => Get.back(result: true),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
