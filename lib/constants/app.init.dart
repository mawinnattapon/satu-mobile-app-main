import 'package:get/get.dart';
import 'package:satu/modules/controller/app.ctrl.dart';
import 'package:satu/modules/controller/user.ctrl.dart';
import 'package:satu/provider/main.provider.dart';
import 'package:satu/utils/http.dart';

class AppInit implements Bindings {
  @override
  void dependencies() {
    Get.put(Http(), permanent: true);
    Get.put(AppController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(MainController(), permanent: true);
  }
}
