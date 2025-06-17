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

class ForgotPwdScreen extends StatefulWidget {
  const ForgotPwdScreen({super.key});

  @override
  State<ForgotPwdScreen> createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {
  final userCtrl = Get.put(UserController());
  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> email = TextEditingController(text: "").obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      title: 'Forgot Password',
      isSetting: false,
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.h),
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
                          'Forgot your password',
                          style: AppTextStyle.hsetStyle(
                            colors: AppColor.black,
                            size: 4.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Column(
                            children: [
                              FormInput(
                                controller: email.value,
                                title: 'Email Account',
                                hintText: 'Enter your Email Account',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your Email Account';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: double.infinity,
                                child: Button(
                                  onPressed: onSubmit,
                                  child: Text(
                                    'Submit',
                                    style: AppTextStyle.w1Style(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      try {
        await userCtrl.fetchForgotPassword(email.value.text.trim());
      } catch (e) {
        //
      }
    }
  }
}
