import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/constants/app.modal.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/modules/repo/lookup.repo.dart';

class LookUpController extends GetxController {
  static LookUpController get instance => Get.find();

  final lookupRepo = LookUpRepo();

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  setIsLoading(bool data) {
    _isLoading.value = data;
    update();
  }

  Future<List> fetchFormsType() async {
    //
    setIsLoading(true);
    try {
      RestApi res = await lookupRepo.getFormsType();
      if (res.status == 'ok') {
        return List.from(res.data);
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      debugPrint("catch :: $e");
    }
    setIsLoading(false);
    update();
    return [];
  }
}
