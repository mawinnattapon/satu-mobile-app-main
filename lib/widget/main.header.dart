import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/models/assm/scan.model.dart';
import 'package:satu/widget/app/card.border.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required this.scanModel,
  });

  final ScanModel scanModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75.w,
      // height: 15.h,
      child: CardBorder(
        isShadow: false,
        isBorder: false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${scanModel.categoryName}',
                          style: AppTextStyle.hsetStyle(
                            colors: AppColor.black,
                            size: 3.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '${scanModel.categoryName} - ${scanModel.projectName} - ${scanModel.eqmNo}',
                          style: AppTextStyle.setStyle(
                            colors: AppColor.black,
                            size: 2.5.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  scanModel.active == 1
                      ? Center(
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
                        )
                      : Center(
                          child: Container(
                            width: 20.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: AppColor.danger.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'InActive',
                                  style: AppTextStyle.setStyle(
                                    colors: AppColor.black,
                                    size: 3.h,
                                  ),
                                ),
                                Container(
                                  width: 4.h,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.danger.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColor.danger,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Article no.',
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ":",
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      scanModel.modelname ?? "",
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seriel number',
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      ":",
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      scanModel.altNo ?? "",
                      style: AppTextStyle.b1Style().copyWith(fontSize: 2.5.h),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
