import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.images.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.size.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/library/button.dart';
import 'package:satu/library/input.dart';
import 'package:satu/modules/controller/app.ctrl.dart';
import 'package:satu/modules/controller/user.ctrl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userCtrl = Get.put(UserController());
  final appCtrl = AppController.instance;
  final formKey = GlobalKey<FormState>();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSize.padingDefault),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 7.h),
                  Image.asset(
                    AppImage.imageLogo,
                    fit: BoxFit.fill,
                    height: 18.h,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Login to your account',
                    style: AppTextStyle.hsetStyle(
                      colors: AppColor.black,
                      size: 4.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 60.h,
                    child: Column(
                      children: [
                        FormInput(
                          controller: userCtrl.email.value,
                          focusNode: userCtrl.emailFocus,
                          onSubmitted: (v) => FocusScope.of(context).requestFocus(userCtrl.passwordFocus),
                          title: 'Email',
                          hintText: 'Enter your email',
                          validator: (value) {
                            String p =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(p);
                            if (value == null || value.isEmpty) {
                              return 'Enter your email';
                            }
                            if (!value.contains(regExp)) {
                              return 'Please fill in your email address correctly';
                            }
                            return null;
                          },
                        ),
                        FormInput(
                          controller: userCtrl.password.value,
                          isPassword: !_isVisible,
                          focusNode: userCtrl.passwordFocus,
                          onSubmitted: (v) => userCtrl.fetchLogin(),
                          title: 'Password',
                          hintText: 'Enter your password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: _isVisible
                                ? const Icon(Icons.remove_red_eye, color: AppColor.primary)
                                : const Icon(Icons.remove_red_eye_outlined, color: AppColor.primary),
                          ),
                        ),
                        Row(
                          children: [
                            appCtrl.config.register
                                ? Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () => Get.toNamed(AppRoutes.signup),
                                        child: Text(
                                          'Register',
                                          style: AppTextStyle.setStyle(colors: AppColor.primary, size: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Get.toNamed(AppRoutes.forGotScreen),
                                  child: Text(
                                    'Forgot?',
                                    style: AppTextStyle.setStyle(colors: AppColor.primary, size: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                userCtrl.fetchLogin();
                              }
                            },
                            child: Text('Login now', style: AppTextStyle.w2Style()),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () => Get.toNamed(AppRoutes.privacy),
                            child: Text(
                              'Privacy & Policy',
                              style: AppTextStyle.setStyle(colors: AppColor.grey.shade700, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
