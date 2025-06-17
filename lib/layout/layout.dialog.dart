import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';

class LayoutDialog extends StatefulWidget {
  final double? height;
  final bool isHeight;
  final String titleHeader;
  final String title;
  final String subtitle;
  final String image;
  final IconData icons;
  const LayoutDialog({
    super.key,
    this.height,
    this.isHeight = true,
    required this.title,
    this.subtitle = "",
    this.image = "",
    required this.icons,
    required this.titleHeader,
  });

  @override
  State<StatefulWidget> createState() => LayoutDialogState();
}

class LayoutDialogState extends State<LayoutDialog> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    // controller.addListener(() {
    //   setState(() {});
    // });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              width: 40.w,
              height: widget.isHeight ? 35.h : widget.height,
              decoration: ShapeDecoration(
                color: AppColor.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.close,
                            color: AppColor.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   widget.image.isEmpty ? AppTextImage.timageFailed : widget.image,
                        //   fit: BoxFit.fill,
                        //   height: 10.h,
                        // ),
                        Icon(
                          widget.icons,
                          size: 10.h,
                          color: AppColor.warning,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          widget.titleHeader,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.hsetStyle(
                            colors: AppColor.black,
                            size: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.p1Style(),
                        ),
                        SizedBox(height: 0.5.h),
                        widget.subtitle.isEmpty
                            ? Container()
                            : Text(
                                widget.subtitle,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.p2Style(),
                              ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class LayoutDefault extends StatefulWidget {
  final double height;
  final Widget child;
  final String title;
  const LayoutDefault({
    super.key,
    this.height = 100,
    required this.child,
    this.title = "",
  });

  @override
  State<StatefulWidget> createState() => LayoutDefaultState();
}

class LayoutDefaultState extends State<LayoutDefault> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(8),
            height: widget.height,
            width: 40.w,
            decoration: ShapeDecoration(
                color: AppColor.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: [
                widget.title.isEmpty
                    ? Container()
                    : SizedBox(
                        height: 6.h,
                        // decoration: ShapeDecoration(
                        //   color: AppColor.grey.shade300,
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(15),
                        //       topRight: Radius.circular(15),
                        //     ),
                        //   ),
                        // ),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              widget.title,
                              style: AppTextStyle.b2Style(),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.close,
                              color: AppColor.grey.shade900,
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
