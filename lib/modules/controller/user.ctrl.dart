import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/constants/app.modal.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/models/user/user.profile.model.dart';
import 'package:satu/modules/repo/user.repo.dart';
import 'package:satu/modules/service/user.service.dart';
import 'package:satu/provider/main.provider.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final mPvd = Get.put(MainController());

  final userRepo = UserRepo();

  // Rx<TextEditingController> email = TextEditingController(text: "member@user.com").obs;
  // Rx<TextEditingController> password = TextEditingController(text: "member@1234").obs;
  Rx<TextEditingController> email = TextEditingController(text: "").obs;
  Rx<TextEditingController> password = TextEditingController(text: "").obs;

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final Rx<bool> _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  setIsLoading(bool data) {
    _isLoading.value = data;
    update();
  }

  final _userModel = Rxn<Profile>();

  Profile? get userModel => _userModel.value;

  setUserModel(Profile data) {
    _userModel.value = data;
    update();
  }

  Future<void> fetchLogin() async {
    Loading.show();
    try {
      RestApi res = await userRepo.signin(
        body: {
          "email": email.value.text.trim(),
          "password": password.value.text.trim(),
          "platform": "mobile",
        },
      );
      if (res.status == 'ok') {
        Profile user = Profile.fromJson(res.data['profile'], token_: res.data['token']);
        await UserService.setSession(user).then((value) {
          clearForm();
          Get.offAllNamed(AppRoutes.qrScannerScreen);
        });
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      debugPrint("catch :: $e");
    }
    Loading.close();
    update();
  }

  Future<void> fetchProfile(Profile user) async {
    try {
      await UserService.setSession(user);
      RestApi res = await userRepo.getprofile();
      if (res.code == 200) {
        Profile user = Profile.fromJson(
          res.data,
          token_: mPvd.token.value,
        );
        await UserService.setSession(user).then((value) {
          clearForm();
          Get.offAllNamed(AppRoutes.qrScannerScreen);
        });
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.loginScreen);
      debugPrint(e.toString());
    }
  }

  Future<void> fetchSignout({bool alert = true}) async {
    bool? status = alert
        ? await AppModal.confirm(
            "Logout",
            "Are you sure Logout?",
            confirm: "Logout",
          )
        : true;
    if (status == true) {
      try {
        await userRepo.signout();
        mPvd.clearSession();
        setUserModel(Profile());
        await UserService.deleteUser();
        Get.offNamed(AppRoutes.splashScreen);
      } catch (e) {
        mPvd.clearSession();
        setUserModel(Profile());
        await UserService.deleteUser();
        Get.offNamed(AppRoutes.splashScreen);
      }
    }
  }

  Future<void> fetchChangePwdPassword(
    String oldPassword,
    String newPassword,
    String newPasswordConfirm,
  ) async {
    Loading.show();
    try {
      RestApi res = await userRepo.changePassword(
        body: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "new_password_confirm": newPasswordConfirm,
        },
      );
      if (res.status == 'ok') {
        clearForm();
        AppModal.succfu(
          header: res.message,
          title: "Password has changed. Please Login again.",
          onThan: () async {
            await fetchSignout(alert: false);
          },
        );
      } else {
        AppModal.alert(title: res.message);
      }
    } catch (e) {
      debugPrint("catch :: $e");
      AppModal.alert(title: e.toString());
    } finally {
      Loading.close();
      update();
    }
  }

  Future<void> signup(
    String fname,
    String lname,
    String email,
    String pass,
    String passConfirm,
  ) async {
    Loading.show();
    try {
      RestApi res = await userRepo.signup({
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "password": pass,
        "password_confirm": passConfirm,
      });
      if (res.status == 'ok') {
        AppModal.succfu(
          header: res.message,
          title: "We have sent a link to your email for activate your account.\n Please Activate Before Login.",
          onThan: Get.back,
        );
      } else {
        AppModal.alert(title: res.message);
      }
    } catch (e) {
      debugPrint("catch :: $e");
      AppModal.alert(title: e.toString());
    } finally {
      Loading.close();
      update();
    }
  }

  Future<void> fetchForgotPassword(String email) async {
    Loading.show();
    try {
      RestApi res = await userRepo.forgotPassword(body: {"email": email});
      if (res.status == 'ok') {
        AppModal.succfu(
          header: res.message,
          title: "We have sent a link for change password to your email.",
          onThan: () async {
            Get.back();
          },
        );
      } else {
        AppModal.alert(title: res.message);
      }
    } catch (e) {
      debugPrint("catch :: $e");
      AppModal.alert(title: e.toString());
    } finally {
      Loading.close();
    }
  }

  Future<void> removeUser() async {
    bool? status = await AppModal.confirm(
      "Remove Account",
      "Are you sure Remove Account?",
      confirm: "Remove",
    );
    if (status == true) {
      try {
        await userRepo.removeAccount();
        mPvd.clearSession();
        setUserModel(Profile());
        await UserService.deleteUser();
        Get.offNamed(AppRoutes.splashScreen);
      } catch (e) {
        mPvd.clearSession();
        setUserModel(Profile());
        await UserService.deleteUser();
        Get.offNamed(AppRoutes.splashScreen);
      }
    }
  }

  clearForm() {
    email.value.clear();
    password.value.clear();
  }
}
