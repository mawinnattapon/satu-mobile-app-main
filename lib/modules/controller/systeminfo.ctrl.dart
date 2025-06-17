import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satu/constants/app.modal.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/models/system/system.completed.model.dart';
import 'package:satu/models/system/system.fromItem.model.dart';
import 'package:satu/models/system/systeminfo.model.dart';
import 'package:satu/modules/repo/systeminfo.repo.dart';

class SystemInfoController extends GetxController {
  static SystemInfoController get instance => Get.find();

  final systemInfoRepo = SystemInfoRepo();

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  setIsLoading(bool data) {
    _isLoading.value = data;
    update();
  }

  final _systemInfoModel = Rxn<List<SystemInfoModel>>();

  List<SystemInfoModel>? get systemInfoModel => _systemInfoModel.value;

  setSystemInfoModel(List<SystemInfoModel> data) {
    _systemInfoModel.value = data;
    update();
  }

  final _systemFromItemModel = Rxn<SystemFromItemModel>();

  SystemFromItemModel? get systemFromItemModel => _systemFromItemModel.value;

  setSystemFromItemModel(SystemFromItemModel? data) {
    _systemFromItemModel.value = data;
    update();
  }

  final _systemCompletedModel = Rxn<SystemCompletedModel>();

  SystemCompletedModel? get systemCompletedModel => _systemCompletedModel.value;

  setSystemCompletedModel(SystemCompletedModel? data) {
    _systemCompletedModel.value = data;
    update();
  }

  final RxString _dropdownVal = ''.obs;

  String get dropdownVal => _dropdownVal.value;

  setDropdownVal(String? id) {
    _dropdownVal.value = id!;
    update();
  }

  Future<void> fetchSystem({required int eqmId, required int typeId}) async {
    //
    try {
      RestApi res = await systemInfoRepo.getSystem(
        body: {
          "eqm_id": eqmId,
          "type_id": typeId,
        },
      );
      if (res.status == 'ok') {
        // log('res ${res.toJson()}');
        List<SystemInfoModel> list = List.from(res.data).map((e) => SystemInfoModel.fromJson(e)).toList();
        await setSystemInfoModel(list);
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      AppModal.alert(
        title: e.toString(),
      );
    }
    update();
  }

  Future<void> fetchSystemItem({required int eqmId, required int formsId}) async {
    //
    clearStete();
    try {
      RestApi res = await systemInfoRepo.getSystemItem(
        body: {
          "eqm_id": eqmId,
          "forms_id": formsId,
        },
      );
      // log('res ${res.data}');
      if (res.status == 'ok') {
        SystemFromItemModel fromItemModel = SystemFromItemModel.fromJson(res.data);
        for (var element in fromItemModel.questions) {
          if (element.inputType == 'choice') {
            for (var item in element.answers!) {
              if (item.assmAwsChecked == true) {
                element.isselected = item.id;
              }
            }
          }
          if (element.inputType == 'dropdown') {
            for (var item in element.answers!) {
              if (item.assmAwsChecked == true) {
                setDropdownVal(item.id.toString());
              }
            }
          }

          if (element.inputType == 'checkbox-detail') {
            for (var item in element.answers!) {
              item.assmAwsPayload ??= [];
            }
          }

          // if (element.inputType == 'tbl-measuring') {
          //   for (var item in element.answers!) {
          //     // log('item ${item.assmAwsPayload}');
          //     item.tableLiter = item.extra['liter'];
          //     item.tableGallon = item.extra['gallon'];
          //   }
          // }
        }

        await setSystemFromItemModel(fromItemModel);
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      AppModal.alert(
        title: e.toString(),
      );
    }
    update();
  }

  Future<String?> fetchUploadImage({required String image}) async {
    //
    try {
      File imagefile = File(image);
      Uint8List imagebytes = await imagefile.readAsBytes();
      RestApi res = await systemInfoRepo.uploadImage(image: imagebytes);
      if (res.status == 'ok') {
        return res.data as String;
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      debugPrint("catch :: $e");
      return image;
    }
    update();
    return image;
  }

  Future<String?> fetchUploadsignature({required Uint8List imagebytes}) async {
    //
    try {
      RestApi res = await systemInfoRepo.uploadImage(image: imagebytes);
      if (res.status == 'ok') {
        return res.data as String;
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      debugPrint("catch :: $e");
    }
    update();
    return null;
  }

  Future<bool> fetchSystemSave({required SystemFromItemModel model}) async {
    //
    try {
      RestApi res = await systemInfoRepo.getSystemSave(body: model.toJson());
      // log('message :: ${res.data}');
      if (res.status == 'ok') {
        await setSystemCompletedModel(SystemCompletedModel.fromJson(res.data));
        return true;
      } else {
        AppModal.alert(
          title: res.message,
        );
      }
    } catch (e) {
      AppModal.alert(
        title: e.toString(),
      );
    }
    update();
    return false;
  }

  clearStete() {
    setDropdownVal('');
    setSystemFromItemModel(null);
  }
}
