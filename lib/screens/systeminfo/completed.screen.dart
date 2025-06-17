import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/layout.main.dart';
import 'package:satu/library/button.dart';
import 'package:satu/modules/controller/scanner.ctrl.dart';
import 'package:satu/modules/controller/systeminfo.ctrl.dart';
import 'package:satu/utils/date_util.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final scannerCtrl = ScannerController.instance;
  final systemCtrl = SystemInfoController.instance;

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      isappBar: false,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(30),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${scannerCtrl.scanModel!.categoryName}',
                      style: AppTextStyle.hsetStyle(
                        colors: AppColor.black,
                        size: 3.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '${scannerCtrl.scanModel!.categoryName} - ${scannerCtrl.scanModel!.projectName} - ${scannerCtrl.scanModel!.eqmNo}',
                      style: AppTextStyle.setStyle(
                        colors: AppColor.black,
                        size: 2.5.h,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              SvgPicture.asset('assets/image/Done.svg'),
              SizedBox(height: 5.h),
              Text(
                'Your equipment was inspected successfully!',
                style: AppTextStyle.setStyle(
                  colors: AppColor.black,
                  size: 4.h,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                DateUtil.dateDay(systemCtrl.systemCompletedModel?.createdAt),
                style: AppTextStyle.setStyle(
                  colors: AppColor.black,
                  size: 2.h,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.h,
                    child: Button(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.qrScannerScreen);
                      },
                      color: ButtonColor.light,
                      child: Text(
                        'close',
                        style: AppTextStyle.b1Style(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
