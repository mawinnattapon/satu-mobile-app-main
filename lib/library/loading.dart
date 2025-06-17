import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:satu/widget/app/load.widget.dart';

class Loading {
  static Widget init(BuildContext context, Widget? widget) {
    return LoadingProvider(
      themeData: LoadingThemeData(
        tapDismiss: false,
        backgroundColor: Colors.white.withOpacity(0.5),
        loadingBackgroundColor: Colors.transparent,
        loadingSize: const Size(20, 20),
      ),
      loadingWidgetBuilder: (ctx, data) {
        return const LoadWidget();
      },
      child: widget ?? const SizedBox(),
    );
  }

  static void show() {
    showLoadingDialog(tapDismiss: false);
  }

  static void close() {
    hideLoadingDialog();
  }
}
