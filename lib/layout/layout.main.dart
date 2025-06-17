import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.images.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/drawer.dart';

class LayoutMain extends StatefulWidget {
  final String title;
  final bool showBackButton;
  final bool isbottomSheet;
  final bool isappBar;
  final bool isSetting;
  final Color backgroundColor;
  final Widget child;
  final void Function()? onTapSettings;

  const LayoutMain({
    super.key,
    this.title = '',
    this.showBackButton = true,
    required this.child,
    this.onTapSettings,
    this.isbottomSheet = true,
    this.isappBar = true,
    this.isSetting = true,
    this.backgroundColor = AppColor.primary,
  });

  @override
  LayoutMainState createState() => LayoutMainState();
}

class LayoutMainState extends State<LayoutMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool canPop = widget.showBackButton ? ModalRoute.of(context)?.canPop ?? false : false;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: widget.backgroundColor,
      appBar: !widget.isappBar
          ? null
          : AppBar(
              centerTitle: true,
              title: widget.title == ''
                  ? Image.asset(AppImage.imageLogo, fit: BoxFit.fill, height: 4.h)
                  : Text(
                      widget.title,
                      style: AppTextStyle.hsetStyle(
                        colors: AppColor.black,
                        size: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              titleSpacing: (canPop) ? 0 : 16,
              leading: (canPop)
                  ? GestureDetector(
                      onTap: () => Get.back(),
                      child: const Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          color: AppColor.secondary,
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                    )
                  : null,
              actions: [
                widget.isSetting
                    ? GestureDetector(
                        onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Settings', style: AppTextStyle.s2Style()),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
      endDrawer: AppDrawer(scaffoldKey: _scaffoldKey),
      endDrawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          widget.isbottomSheet
              ? Positioned(
                  bottom: 0,
                  child: SafeArea(
                    child: Container(
                      height: 5.h,
                      width: 100.w,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImage.imageLogo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                color: AppColor.transparent,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
