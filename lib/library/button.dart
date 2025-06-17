import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

enum ButtonColor { primary, secondary, warning, danger, light, sky, info, transparent, success, black }

class ButtonTheme {
  static EdgeInsetsGeometry padding(ButtonSize size) {
    EdgeInsetsGeometry data = const EdgeInsets.symmetric(horizontal: 15, vertical: 12);
    if (size == ButtonSize.small) {
      return const EdgeInsets.symmetric(horizontal: 2, vertical: 0);
    }
    if (size == ButtonSize.large) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
    }
    return data;
  }

  static Color textColor(ButtonColor color) {
    Color data = AppColor.primary;
    if (color == ButtonColor.primary) return AppColor.light;
    if (color == ButtonColor.secondary) return AppColor.light;
    if (color == ButtonColor.warning) return AppColor.light;
    if (color == ButtonColor.danger) return AppColor.light;
    if (color == ButtonColor.light) return AppColor.primary;
    if (color == ButtonColor.info) return AppColor.primary;
    if (color == ButtonColor.sky) return AppColor.light;
    if (color == ButtonColor.success) return AppColor.light;
    return data;
  }

  static Color backgroundColor(ButtonColor color) {
    Color data = AppColor.transparent;
    if (color == ButtonColor.primary) return AppColor.primary;
    if (color == ButtonColor.secondary) return AppColor.secondary;
    if (color == ButtonColor.warning) return AppColor.warning;
    if (color == ButtonColor.danger) return AppColor.danger;
    if (color == ButtonColor.light) return AppColor.light;
    if (color == ButtonColor.info) return AppColor.primary.shade100;
    if (color == ButtonColor.sky) return AppColor.sky;
    if (color == ButtonColor.success) return AppColor.success;
    if (color == ButtonColor.black) return AppColor.black;
    return data;
  }

  static Color backgroundActionColor(ButtonColor color) {
    Color data = AppColor.transparent;
    if (color == ButtonColor.primary) return AppColor.primary.shade600;
    if (color == ButtonColor.secondary) return AppColor.secondary.shade600;
    if (color == ButtonColor.warning) return AppColor.warning.shade600;
    if (color == ButtonColor.danger) return AppColor.danger.shade600;
    if (color == ButtonColor.light) return AppColor.light.shade600;
    if (color == ButtonColor.info) return AppColor.primary.shade300;
    if (color == ButtonColor.sky) return AppColor.sky.shade200;
    if (color == ButtonColor.success) return AppColor.bgSuccess;
    return data;
  }
}

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonColor color;
  final ButtonSize size;
  final Color? textColor;
  final double? elevation;
  final WidgetStateProperty<BorderSide?>? side;

  const Button({
    Key? key,
    this.color = ButtonColor.primary,
    this.size = ButtonSize.medium,
    this.textColor,
    this.elevation,
    this.onPressed,
    this.side,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            // padding: WidgetStateProperty.all(ButtonTheme.padding(size)),
            elevation: WidgetStateProperty.all(color == ButtonColor.transparent ? 0 : elevation),
            visualDensity: size == ButtonSize.small ? const VisualDensity(vertical: -2) : null,
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                if (textColor != null) return textColor!;
                return ButtonTheme.textColor(color);
              } else {
                if (textColor != null) return textColor;
                return ButtonTheme.textColor(color);
              }
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ButtonTheme.backgroundColor(color).withOpacity(0.6);
              } else if (states.contains(WidgetState.pressed)) {
                return ButtonTheme.backgroundColor(color);
              } else {
                return ButtonTheme.backgroundColor(color);
              }
            }),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return ButtonTheme.backgroundActionColor(color);
              } else if (states.contains(WidgetState.pressed)) {
                return ButtonTheme.backgroundActionColor(color);
              } else {
                return ButtonTheme.backgroundActionColor(color);
              }
            }),
            side: side ?? WidgetStateProperty.all(BorderSide.none),
          ),
      child: child,
    );
  }
}

class ButtonOutline extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonColor color;
  final ButtonSize size;
  final Color? textColor;
  final double? elevation;
  final double borderWidth;

  const ButtonOutline({
    Key? key,
    this.color = ButtonColor.primary,
    this.size = ButtonSize.medium,
    this.borderWidth = 1,
    this.textColor,
    this.elevation,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        // padding: ButtonTheme.padding(size),
        elevation: 0,
        visualDensity: size == ButtonSize.small ? const VisualDensity(vertical: -2) : null,
        // backgroundColor: ButtonTheme.backgroundColor(color),
        foregroundColor: ButtonTheme.backgroundColor(color),
        disabledForegroundColor: ButtonTheme.backgroundColor(color).withOpacity(0.4),
        side: BorderSide(
          width: borderWidth,
          color: onPressed != null
              ? ButtonTheme.backgroundColor(color)
              : ButtonTheme.backgroundColor(color).withOpacity(0.4),
        ),
      ),
      child: child,
    );
  }
}
