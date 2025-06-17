import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();

  Locale locale = const Locale("th");
  GetStorage storage = GetStorage();
  // remember this to db
  RxString keyId = "".obs;
  RxString atext = "".obs;
  RxString key = "".obs;
  RxString token = "".obs;

  DateTime createTime = DateTime.now();

  void setLocale(Locale locale_) {
    locale = locale_;
    update();
  }

  void setKeyId(String keyId_) {
    keyId.value = keyId_;
    update();
  }

  void setAtext(String transId_) {
    atext.value = transId_;
    update();
  }

  void setKey(String key_) {
    key.value = key_;
    update();
  }

  void setToken(String token_) {
    token.value = token_;
    update();
  }

  void setCreateTime(DateTime createTime_) {
    createTime = createTime_;
    update();
  }

  void clearSession() {
    key.value = "";
    token.value = "";
    keyId.value = "";
    atext.value = "";
    update();
  }
}
