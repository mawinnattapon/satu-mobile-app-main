import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';

class CheckboxDetailWidget extends StatefulWidget {
  final Function(bool) callback;
  final String title;
  final String? subTitle;
  final bool checkbox;

  const CheckboxDetailWidget({
    Key? key,
    required this.callback,
    required this.title,
    this.subTitle,
    this.checkbox = true,
  }) : super(key: key);

  @override
  CheckboxDetailWidgetState createState() => CheckboxDetailWidgetState();
}

class CheckboxDetailWidgetState extends State<CheckboxDetailWidget> {
  late bool _checkbox = widget.checkbox;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColor.primary,
      visualDensity: const VisualDensity(vertical: -4),
      title: Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: Text(
          widget.title,
          style: AppTextStyle.b1Style(),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.subTitle != null && widget.subTitle!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "      ${widget.subTitle!}",
                    style: AppTextStyle.b2Style(),
                  ),
                )
              : Container(),
        ],
      ),
      value: _checkbox,
      onChanged: (value) {
        widget.callback(value!);
        setState(() => _checkbox = !_checkbox);
      },
    );
  }
}
