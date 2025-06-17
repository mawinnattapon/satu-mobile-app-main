import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/models/system/system.fromItem.model.dart';

class CustomRadioGroup extends StatelessWidget {
  final Function(int?) onValueSelected;
  final List<Answer> items;
  final int? groupValue;
  const CustomRadioGroup({
    super.key,
    required this.onValueSelected,
    required this.items,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(items.length, (index) {
        return SizedBox(
          width: 40.h,
          child: Container(
            decoration: BoxDecoration(
              color: (items[index].id == groupValue
                  ? (items[index].warning == false ? AppColor.success.shade100 : AppColor.danger.shade100)
                  : AppColor.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            child: RadioListTile<int>(
              activeColor: (items[index].id == groupValue
                  ? (items[index].warning == false ? AppColor.success : AppColor.danger)
                  : AppColor.grey.shade200),
              // selected: groupValue!,
              title: Text(
                items[index].title,
                style: AppTextStyle.b1Style(),
              ),
              groupValue: groupValue,
              onChanged: onValueSelected,
              value: items[index].id,
            ),
          ),
        );
      }),
    );
  }
}
