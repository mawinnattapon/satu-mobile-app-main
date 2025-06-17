import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:satu/config.dart';
import 'package:satu/constants/app.exception.dart';
import 'package:satu/models/app/rest.api.model.dart';
import 'package:satu/provider/main.provider.dart';

class Http extends getx.GetxController {
  //
  static Http get instance => getx.Get.find();
  var mPvd = getx.Get.put(MainController());

  late Dio rest;
  final BaseOptions options = BaseOptions(
    baseUrl: Config.restUrl,
    connectTimeout: const Duration(milliseconds: 100000),
    receiveTimeout: const Duration(milliseconds: 100000),
  );

  Http() {
    rest = Dio(options);
    // rest.httpClientAdapter = Http2Adapter(
    //   ConnectionManager(
    //     idleTimeout: const Duration(seconds: 10),
    //     onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
    //   ),
    // );
  }

  Future<RestApi> post(String path, Map<String, dynamic> param) async {
    await hasNetwork();

    rest.options.headers = await header();
    rest.options.contentType = Headers.jsonContentType;
    debugPrint('Http-post = $path, param = ${param.toString()}');

    try {
      var res = await rest.post(path, data: param);
      return response(res);
    } on DioException catch (e) {
      if (e.error == "CONNECTION_NOT_SECURE") {
        throw AppException("incorrect".tr);
      }
      Response? res = e.response;
      if (res == null) throw AppException("connection".tr);
      if (res.statusCode == 401) throw "${res.statusCode}";
      if (res.statusCode != 200) {
        throw AppException("${'incorrectError'.tr} [${res.statusCode}]");
      } else {
        throw AppException("connection".tr);
      }
    }
  }

  Future<RestApi> get(String path, Map<String, dynamic>? param) async {
    await hasNetwork();

    rest.options.headers = await header();
    debugPrint('Http-post = $path, param = $param');

    try {
      var res = await rest.get(path, queryParameters: param);
      return response(res);
    } on DioException catch (e) {
      if (e.error == "CONNECTION_NOT_SECURE") {
        throw AppException("incorrect".tr);
      }
      Response? res = e.response;
      if (res == null) throw AppException("connection".tr);
      if (res.statusCode != 200) {
        throw AppException("${'incorrectError'.tr} [${res.statusCode}]");
      } else {
        throw AppException("connection".tr);
      }
    }
  }

  Future<RestApi> upload(String path, Uint8List filesByte, dynamic params) async {
    //
    await hasNetwork();

    FormData formData = FormData();
    MultipartFile fileBody = MultipartFile.fromBytes(
      filesByte,
      filename: "file.png",
      contentType: MediaType("image", "png"),
    );
    
    formData.files.add(MapEntry("file", fileBody));
    rest.options.headers = await header();
    rest.options.contentType = Headers.formUrlEncodedContentType;
    formData.fields.add(MapEntry("param", json.encode(params)));

    debugPrint('Http-upload = $path, param = ${params.toString()}');

    try {
      var res = await rest.post(path, data: formData);
      return response(res);
    } on DioException catch (e) {
      if (e.error == "CONNECTION_NOT_SECURE") throw AppException("incorrect".tr);

      Response? res = e.response;
      if (res == null) throw AppException("connection".tr);
      if (res.statusCode == 401) throw "${res.statusCode}";
      if (res.statusCode != 200) {
        throw AppException("${'incorrectError'.tr} [${res.statusCode}]");
      } else {
        throw AppException("connection".tr);
      }
    }
  }

  Future<Map<String, String>> header() async {
    // AppInfoModel info = mPvd.appInfo;
    Map<String, String> headers = {
      // "user-agent": "${info.os}(${info.model}, ${info.osVersion}, v.${info.version}), (${info.udid})",
      // "data-code": cryp.ivText,
      // "Lang": mPvd.storage.read('locale') ?? "th",
    };
    String? token = mPvd.token.value;
    if (token.isNotEmpty) headers['Authorization'] = "Bearer $token";

    return headers;
  }

  Future<RestApi> response(Response res) async {
    if (res.statusCode != 200) {
      throw AppException("${'incorrectError'.tr} [${res.statusCode}]");
    }
    var body = res.data;
    Map<String, dynamic> rs = {};
    try {
      rs = body;
    } catch (e) {
      throw AppException("invalid".tr);
    }
    if (!rs.containsKey('status')) throw AppException("invalid".tr);
    return RestApi.fromJson(rs);
  }

  Future<void> hasNetwork() async {
    bool connect = await hasInternet();
    if (!connect) throw AppException("connection".tr);
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup("8.8.8.8");
      if (result.isEmpty) throw AppException("connection fail");
      return true;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  // Future<void> checkTokenExpire(
  //     BuildContext MainProvider mPvd, UserProvider uPvd) async {
  //   int diff = DateUtil.diffMinute(mPvd.createTime, DateTime.now());
  //   if (diff > Config.limitSession) {
  //     if (uPvd.user != null) {
  //       // await AppService().renewUserToken(uPvd.user!);
  //     } else {
  //       await AppService().createToken(context);
  //     }
  //   }
  // }
}
