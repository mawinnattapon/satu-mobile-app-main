import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';

class FormInput extends StatefulWidget {
  final String title;
  final String? hintText;
  final String labelText;
  final bool readOnly;
  final bool disabled;
  final bool isRequired;
  final bool isPassword;
  final bool autofocus;
  final TextInputType type;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(String?)? onSubmitted;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final TextAlignVertical? textAlignVertical;
  final String? initialValue;

  const FormInput({
    Key? key,
    this.title = "",
    this.hintText,
    this.labelText = "",
    this.readOnly = false,
    this.disabled = false,
    this.isRequired = false,
    this.isPassword = false,
    this.autofocus = false,
    this.type = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.inputFormatters,
    this.validator,
    this.controller,
    this.focusNode,
    this.icon,
    this.suffixIcon,
    this.onTap,
    this.onSubmitted,
    this.onSaved,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.fillColor,
    this.textInputAction,
    this.onEditingComplete,
    this.textAlignVertical,
    this.initialValue,
  }) : super(key: key);

  @override
  FormInputState createState() => FormInputState();
}

class FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: widget.isRequired
                      ? Row(
                          children: [
                            Text(
                              widget.title,
                            ),
                            const Text("*", style: TextStyle(color: AppColor.danger)),
                          ],
                        )
                      : Text(
                          widget.title,
                          style: AppTextStyle.setStyle(
                            colors: AppColor.grey,
                            size: 20,
                          ),
                        ),
                )
              : const SizedBox(),
          TextFormField(
            initialValue: widget.initialValue,
            textAlign: widget.textAlign,
            keyboardType: widget.type,
            controller: widget.controller,
            focusNode: widget.focusNode,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            textAlignVertical: widget.textAlignVertical,
            readOnly: widget.readOnly,
            enabled: !widget.disabled,
            enableInteractiveSelection: !widget.readOnly,
            obscureText: widget.isPassword,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            // minLines: widget.minLines,
            onSaved: widget.onSaved,
            onFieldSubmitted: widget.onSubmitted,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            style: AppTextStyle.b2Style(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.icon != null ? Icon(widget.icon, color: AppColor.primary) : null,
              suffixIcon: widget.suffixIcon,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              labelText: widget.labelText != '' ? widget.labelText : null,
            ),
          )
        ],
      ),
    );
  }
}
