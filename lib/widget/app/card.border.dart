import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';

class CardBorder extends StatelessWidget {
  final Color color;
  final Color background;
  final bool isShadow;
  final bool isBorder;
  final Widget child;
  const CardBorder({
    Key? key,
    this.color = AppColor.primary,
    this.background = AppColor.light,
    this.isShadow = true,
    this.isBorder = true,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: isBorder ? Border.all(color: color, width: 2) : null,
        color: background,
        boxShadow: isShadow
            ? [
                // BoxShadow(
                //   color: AppColor.grey.withOpacity(0.3),
                //   blurRadius: 6,
                //   offset: const Offset(0, 2),
                // ),
                const BoxShadow(
                    color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4),
              ]
            : null,
      ),
      child: child,
    );
  }
}
