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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final userCtrl = Get.put(UserController());
  final formKey = GlobalKey<FormState>();
  Rx<TextEditingController> fname = TextEditingController(text: "").obs;
  Rx<TextEditingController> lname = TextEditingController(text: "").obs;
  Rx<TextEditingController> email = TextEditingController(text: "").obs;
  Rx<TextEditingController> pass = TextEditingController(text: "").obs;
  Rx<TextEditingController> passConfirm = TextEditingController(text: "").obs;
  Rx<bool> isShowPwd = false.obs;
  Rx<bool> isShowPwdConfirm = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      title: 'Signup',
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
                  child: Obx(() {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Signup General Account',
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
                                  controller: fname.value,
                                  title: 'First Name',
                                  hintText: 'Enter your First Name',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Required!';
                                    return null;
                                  },
                                ),
                                FormInput(
                                  controller: lname.value,
                                  title: 'Last Name',
                                  hintText: 'Enter your Last Name',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Required!';
                                    return null;
                                  },
                                ),
                                FormInput(
                                  controller: email.value,
                                  title: 'Email Account',
                                  hintText: 'Enter your Email Account',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Required!';
                                    if (!hasEmail(value)) return 'Invalid Email format.';
                                    return null;
                                  },
                                ),
                                FormInput(
                                  controller: pass.value,
                                  isPassword: !isShowPwd.value,
                                  title: 'Password',
                                  hintText: 'Enter your Password',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Required!';
                                    return null;
                                  },
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isShowPwd.value = !isShowPwd.value;
                                    },
                                    child: isShowPwd.value
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
                                  controller: passConfirm.value,
                                  isPassword: !isShowPwdConfirm.value,
                                  title: 'Confirm Password',
                                  hintText: 'Enter Confirm Password',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return 'Required!';
                                    return null;
                                  },
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      isShowPwdConfirm.value = !isShowPwdConfirm.value;
                                    },
                                    child: isShowPwdConfirm.value
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
                                    child: Text(
                                      'Signup',
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
                    );
                  }),
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool hasEmail(String txt) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(txt);
  }

  void onSubmit() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      await userCtrl.signup(
        fname.value.text.trim(),
        lname.value.text.trim(),
        email.value.text.trim(),
        pass.value.text.trim(),
        passConfirm.value.text.trim(),
      );
    }
  }
}
