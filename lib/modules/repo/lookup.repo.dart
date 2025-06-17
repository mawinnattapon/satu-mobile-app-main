import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/utils/http.dart';

class LookUpRepo {
  final rest = Get.put(Http());

  Future<RestApi> getFormsType() async {
    try {
      final res = await rest.get('/lookup/form_type', {});
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }
}
