import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/layout.main.dart';
import 'package:satu/library/button.dart';
import 'package:satu/library/input.dart';
import 'package:satu/modules/controller/user.ctrl.dart';
import 'package:satu/widget/app/card.border.dart';

class ChangePwdScreen extends StatefulWidget {
  const ChangePwdScreen({super.key});

  @override
  State<ChangePwdScreen> createState() => _ChangePwdScreenState();
}

class _ChangePwdScreenState extends State<ChangePwdScreen> {
  final userCtrl = Get.put(UserController());
  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> oldPassword = TextEditingController(text: "").obs;
  Rx<TextEditingController> newPassword = TextEditingController(text: "").obs;
  Rx<TextEditingController> newPasswordConfirm = TextEditingController(text: "").obs;
  bool _isShowPwdOld = false;
  bool _isShowPwdNew = false;
  bool _isShowPwdConf = false;

  @override
  void initState() {
    super.initState();
    userCtrl.clearForm();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      title: 'Change Password',
      isSetting: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardBorder(
                isShadow: false,
                isBorder: false,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Change your password',
                        style: AppTextStyle.hsetStyle(
                          colors: AppColor.black,
                          size: 4.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          FormInput(
                            controller: oldPassword.value,
                            isPassword: !_isShowPwdOld,
                            // focusNode: passwordFocus,
                            title: 'Current password',
                            hintText: 'Enter your Current password',
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Required!';
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isShowPwdOld = !_isShowPwdOld;
                                });
                              },
                              child: _isShowPwdOld
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColor.primary,
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.primary,
                                    ),
                            ),
                          ),
                          FormInput(
                            controller: newPassword.value,
                            isPassword: !_isShowPwdNew,
                            // focusNode: passwordFocus,
                            title: 'New password',
                            hintText: 'Enter your New password',
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Required!';
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isShowPwdNew = !_isShowPwdNew;
                                });
                              },
                              child: _isShowPwdNew
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColor.primary,
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.primary,
                                    ),
                            ),
                          ),
                          FormInput(
                            controller: newPasswordConfirm.value,
                            isPassword: !_isShowPwdConf,
                            // focusNode: passwordFocus,
                            title: 'Confirm password',
                            hintText: 'Enter Confirm password',
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Required!';
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isShowPwdConf = !_isShowPwdConf;
                                });
                              },
                              child: _isShowPwdConf
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColor.primary,
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColor.primary,
                                    ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            width: double.infinity,
                            child: Button(
                              onPressed: onSubmit,
                              child: Text('Submit', style: AppTextStyle.w1Style()),
                            ),
                          ),
                          SizedBox(height: 3.h),
                        ],
                      ),
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

  void onSubmit() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      userCtrl.fetchChangePwdPassword(
        oldPassword.value.text.trim(),
        newPassword.value.text.trim(),
        newPasswordConfirm.value.text.trim(),
      );
    }
  }
}
