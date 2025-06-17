import 'package:flutter/material.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;
  final String title;
  final bool checkbox;

  const CheckboxWidget({
    Key? key,
    required this.callback,
    required this.title,
    this.checkbox = true,
  }) : super(key: key);

  @override
  CheckboxWidgetState createState() => CheckboxWidgetState();
}

class CheckboxWidgetState extends State<CheckboxWidget> {
  late bool _checkbox = widget.checkbox;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColor.primary,
      title: Text(
        widget.title,
        style: AppTextStyle.b2Style(),
      ),
      value: _checkbox,
      onChanged: (value) {
        widget.callback(value!);
        setState(() => _checkbox = !_checkbox);
      },
    );
  }
}
