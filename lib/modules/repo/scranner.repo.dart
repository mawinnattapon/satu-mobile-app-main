import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/utils/http.dart';

class ScannerRepo {
  final rest = Get.put(Http());

  Future<RestApi> getQRCode({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/assm/equipment/find', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }
}
