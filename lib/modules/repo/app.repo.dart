import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/utils/http.dart';

class AppRepo {
  final rest = Get.put(Http());

  Future<RestApi> getConfig() async {
    try {
      final res = await rest.get('/config', {});
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }
}
