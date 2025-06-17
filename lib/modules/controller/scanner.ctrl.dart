import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/constants/app.modal.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/models/assm/scan.model.dart';
import 'package:satu/modules/repo/scranner.repo.dart';

class ScannerController extends GetxController {
  static ScannerController get instance => Get.find();

  final scannerRepo = ScannerRepo();
//
  // Rx<TextEditingController> codeText = TextEditingController(text: "SN270000676863").obs;
  Rx<TextEditingController> codeText = TextEditingController(text: "").obs;

  final _scanModel = Rxn<ScanModel>();

  ScanModel? get scanModel => _scanModel.value;

  setScanModel(ScanModel data) {
    _scanModel.value = data;
    update();
  }

  Future<bool> fetchQRCode(String qrCode) async {
    //
    Loading.show();
    try {
      RestApi res = await scannerRepo.getQRCode(
        body: {
          "code": qrCode,
        },
      );
      log('res ${res.data}');
      if (res.status == 'ok') {
        await setScanModel(ScanModel.fromJson(res.data));

        return true;
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      debugPrint("catch :: $e");
    } finally {
      Loading.close();
    }

    return false;
  }
}
