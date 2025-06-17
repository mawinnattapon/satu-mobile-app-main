import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.size.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/layout.main.dart';
import 'package:satu/modules/controller/lookup.ctrl.dart';
import 'package:satu/modules/controller/scanner.ctrl.dart';
import 'package:satu/widget/app/card.border.dart';
import 'package:satu/widget/app/load.widget.dart';
import 'package:satu/widget/main.header.dart';

class ChecklistsScreen extends StatefulWidget {
  const ChecklistsScreen({super.key});

  @override
  State<ChecklistsScreen> createState() => _ChecklistsScreenState();
}

class _ChecklistsScreenState extends State<ChecklistsScreen> {
  final lookupCtrl = Get.put(LookUpController());
  final scannerCtrl = ScannerController.instance;
  List<dynamic> formType = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    formType = await lookupCtrl.fetchFormsType();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSize.padingDefault),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            MainHeader(scanModel: scannerCtrl.scanModel!),
            SizedBox(height: 4.h),
            formType.isEmpty
                ? const LoadWidget(
                    colors: [AppColor.secondary],
                  )
                : buildBody()
          ],
        ),
      ),
    );
  }

  SizedBox buildBody() {
    return SizedBox(
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
                    'Choose your option',
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
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: formType.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.systemInfoScreen, arguments: {'formstype': formType[index]});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      width: 75.w,
                      height: 12.h,
                      child: CardBorder(
                        background: AppColor.primary.shade50,
                        isShadow: false,
                        isBorder: false,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '${formType[index]['label']}',
                                    style: AppTextStyle.b1Style(),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Select',
                                  style: AppTextStyle.p1Style(),
                                ),
                              ),
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
    );
  }
}
