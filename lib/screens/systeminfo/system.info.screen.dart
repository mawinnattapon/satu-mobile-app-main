import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/layout.main.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/models/system/systeminfo.model.dart';
import 'package:satu/modules/controller/scanner.ctrl.dart';
import 'package:satu/modules/controller/systeminfo.ctrl.dart';
import 'package:satu/utils/date_util.dart';
import 'package:satu/widget/app/card.border.dart';
import 'package:satu/widget/main.header.dart';

class SystemInfoScreen extends StatefulWidget {
  const SystemInfoScreen({super.key});

  @override
  State<SystemInfoScreen> createState() => _SystemInfoScreenState();
}

class _SystemInfoScreenState extends State<SystemInfoScreen> {
  final systemCtrl = Get.put(SystemInfoController());
  final scannerCtrl = ScannerController.instance;

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Loading.show();
    data = Get.arguments['formstype'];
    await systemCtrl.fetchSystem(eqmId: scannerCtrl.scanModel!.id!, typeId: data['value']);
    setState(() {});
    Loading.close();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      title: '${data['label']}',
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 5.h),
              MainHeader(scanModel: scannerCtrl.scanModel!),
              SizedBox(height: 4.h),
              SizedBox(
                width: 75.w,
                child: CardBorder(
                  isShadow: false,
                  isBorder: false,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icon/option.svg'),
                            SizedBox(width: 1.h),
                            Text(
                              '${data['label']}',
                              style: AppTextStyle.hsetStyle(
                                colors: AppColor.black,
                                size: 3.5.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        ListView.builder(
                          primary: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: systemCtrl.systemInfoModel?.length ?? 0,
                          itemBuilder: (context, index) {
                            SystemInfoModel systemInfo = systemCtrl.systemInfoModel![index];
                            return GestureDetector(
                              onTap: isCheckBTN(systemInfo)
                                  ? null
                                  : () {
                                      Get.toNamed(AppRoutes.stepSystemScreen, arguments: systemInfo)!
                                          .then((value) => init());
                                    },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                width: 75.w,
                                // height: 13.h,
                                child: CardBorder(
                                  background: AppColor.primary.shade50,
                                  isShadow: false,
                                  isBorder: false,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(systemInfo.name, style: AppTextStyle.b1Style()),
                                        SizedBox(height: 1.h),
                                        systemInfo.lastStatus == null
                                            ? Text(
                                                'Ready',
                                                style: AppTextStyle.setStyle(
                                                  colors: AppColor.primary.shade500,
                                                  size: 18,
                                                ),
                                              )
                                            : Container(),
                                        systemInfo.lastStatus == 0
                                            ? Text(
                                                'In Progress : ${DateUtil.dateDay(systemInfo.lastDate)}',
                                                style: AppTextStyle.setStyle(
                                                  colors: AppColor.primary.shade500,
                                                  size: 18,
                                                ),
                                              )
                                            : Container(),
                                        systemInfo.lastStatus == 1 || systemInfo.lastStatus == 2
                                            ? Text(
                                                'Submitted : ${DateUtil.dateDay(systemInfo.lastDate)}',
                                                style: AppTextStyle.setStyle(
                                                  colors: AppColor.success,
                                                  size: 18,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  bool isCheckBTN(SystemInfoModel systemInfo) {
    if (systemInfo.allowRepeat == false && systemInfo.lastId != null && systemInfo.lastStatus != 0) {
      return true;
    } else {
      if (systemInfo.allowRepeat == true &&
          systemInfo.lastId != null &&
          systemInfo.lastStatus != 0 &&
          systemInfo.lastStatus != null) {
        return true;
      } else {
        return false;
      }
    }
  }

  SizedBox buildHeader() {
    return SizedBox(
      width: 75.w,
      height: 15.h,
      child: CardBorder(
        isShadow: false,
        isBorder: false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fire Extinguisher',
                      style: AppTextStyle.hsetStyle(
                        colors: AppColor.black,
                        size: 3.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Fire Extinguisher Floor 1st · CO2-IPG-001 · Customer A',
                      style: AppTextStyle.setStyle(
                        colors: AppColor.black,
                        size: 2.5.h,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: 20.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: AppColor.success.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Ready',
                        style: AppTextStyle.setStyle(
                          colors: AppColor.black,
                          size: 3.h,
                        ),
                      ),
                      Container(
                        width: 4.h,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColor.success.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppColor.success,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
