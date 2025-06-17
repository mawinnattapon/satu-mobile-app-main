import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/utils/http.dart';
import 'package:satu/models/app/rest.api.model.dart';

class UserRepo {
  final rest = Get.put(Http());

  //repo
  Future<RestApi> signin({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/auth/signin', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> getprofile() async {
    try {
      RestApi res = await rest.get('/profile', {});
      debugPrint("res :: ${res.toJson()}");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> signout() async {
    try {
      RestApi res = await rest.get('/auth/signout', {});
      debugPrint("res :: ${res.toJson()}");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> removeAccount() async {
    try {
      RestApi res = await rest.get('/profile/remove', {});
      debugPrint("res :: ${res.toJson()}");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> changePassword({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/profile/password/change', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> forgotPassword({required Map<String, dynamic> body}) async {
    try {
      final res = await rest.post('/auth/password/forgot', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }

  Future<RestApi> signup(Map<String, dynamic> body) async {
    try {
      final res = await rest.post('/auth/signup', body);
      debugPrint("res :: $res");
      return res;
    } catch (e) {
      debugPrint("Error :: $e");
      rethrow;
    }
  }
}
