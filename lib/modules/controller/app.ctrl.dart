import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:satu/config.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.db.dart';
import 'package:satu/constants/app.exception.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/models/app/config.model.dart';
import 'package:satu/models/app/info.model.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/models/user/user.profile.model.dart';
import 'package:satu/modules/controller/user.ctrl.dart';
import 'package:satu/modules/repo/app.repo.dart';
import 'package:satu/modules/repo/user.repo.dart';
import 'package:satu/modules/service/user.service.dart';
import 'package:satu/provider/main.provider.dart';
import 'package:satu/utils/http.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppController extends GetxController {
  static AppController get instance => Get.find();

  final mCtrl = Get.put(MainController());
  final userCtrl = Get.put(UserController());
  final httpCtrl = Get.put(Http());

  final appRepo = AppRepo();
  final userRepo = UserRepo();

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final Rx<AppComfig> _config = AppComfig().obs;
  AppComfig get config => _config.value;

  final Rx<AppInfo> _info = AppInfo().obs;
  AppInfo get info => _info.value;

  setIsLoading(bool data) {
    _isLoading.value = data;
    update();
  }

  Future<void> validDb() async {
    bool db = await AppDb.isOpen();
    if (!db) await AppDb.rmDB();
  }

  Future<void> init() async {
    await validDb();
    try {
      await getInfo();
      await loadConfig();
      await loadConfig();
      if (allowVersion()) {
        Profile? user = await UserService.getUser();
        if (user != null) {
          // getUser
          await userCtrl.fetchProfile(user);
        } else {
          //login
          Get.offAllNamed(AppRoutes.loginScreen);
        }
      } else {
        openUpdateDialog();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  Future<void> loadConfig() async {
    RestApi res = await appRepo.getConfig();
    if (res.status != "ok") throw AppException("Load Fail.");
    _config.value = AppComfig.fromJson(res.data);
    update();
  }

  Future<void> getInfo() async {
    PackageInfo inf = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;
    AppInfo appInfo = AppInfo();
    appInfo.version = inf.version;
    appInfo.buildNumber = inf.buildNumber;
    appInfo.brand = info.name;
    appInfo.os = info.systemName;
    appInfo.osVersion = info.systemVersion;
    appInfo.model = info.model;
    _info.value = appInfo;
    update();
  }

  Future<void> openUpdateDialog() async {
    Get.defaultDialog(
      title: "New Update!!",
      content: const Text("Please Update Appplication"),
      textConfirm: "Update",
      confirmTextColor: AppColor.light,
      backgroundColor: AppColor.light,
      buttonColor: AppColor.primary,
      titlePadding: const EdgeInsets.only(top: 24),
      contentPadding: const EdgeInsets.only(bottom: 24),
      onConfirm: () => openStore(),
      onWillPop: () async => false,
    );
  }

  Future<void> openStore() async {
    try {
      await launchUrlString(Config.storeUrl);
    } catch (e) {
      await launchUrlString(
        Config.storeUrl.replaceFirst("itms-apps://", "https://"),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  bool allowVersion() {
    if (info.version.isNotEmpty && config.version.isNotEmpty) {
      return config.force ? checkVersion(config.version, info.version) : true;
    } else {
      return true;
    }
  }

  bool checkVersion(String store, String device) {
    List<int> stor = store.split(".").map((e) => int.parse(e)).toList();
    List<int> devi = device.split(".").map((e) => int.parse(e)).toList();
    if (devi[0] > stor[0]) {
      return true;
    } else if (devi[0] == stor[0]) {
      if (devi[1] > stor[1]) {
        return true;
      } else if (devi[1] == stor[1]) {
        if (devi[2] > stor[2]) {
          return true;
        } else if (devi[2] == stor[2]) {
          if (devi[2] > stor[2]) {
            return true;
          } else if (devi[2] == stor[2]) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
