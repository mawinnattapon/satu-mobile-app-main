import 'package:get/get.dart';
import 'package:satu/constants/app.db.dart';
import 'package:satu/models/user/user.profile.model.dart';
import 'package:satu/modules/controller/user.ctrl.dart';
import 'package:satu/provider/main.provider.dart';

class UserService {
  UserService._();
  static final userctrl = Get.put(UserController());
  static final mPvd = Get.put(MainController());

  static String table = 'user';
  static int dbid = 1;

  static Future<bool> setSession(Profile user) async {
    userctrl.setUserModel(user);
    mPvd.setToken(user.token.toString());

    await deleteUser();
    await insertUser(user);
    return true;
  }

  static Future<Profile?> getUser() async {
    var user = await AppDb.first(table, dbid);
    return user != null ? Profile.fromJsonUser(user) : null;
  }

  static Future insertUser(Profile user) async {
    return await AppDb.insert(table, user.toJsonDbUser());
  }

  static Future deleteUser() async {
    return await AppDb.delete(table, dbid);
  }
}
