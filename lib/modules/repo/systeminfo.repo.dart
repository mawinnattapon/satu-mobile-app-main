import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/utils/http.dart';
import 'dart:convert'; // Add this line

class SystemInfoRepo {
  final rest = Get.put(Http());

  Future<RestApi> getSystem({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/assm/equipment/forms/list', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> getSystemItem({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/assm/equipment/forms/item', body);
      // debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> uploadImage({required Uint8List image}) async {
    try {
      final res = await rest.upload('/file/upload/image', image, {});
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> getSystemSave({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/assm/equipment/forms/save', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }
}
