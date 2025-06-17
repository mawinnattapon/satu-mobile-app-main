import 'package:get/get.dart';
import 'package:satu/modules/controller/app.ctrl.dart';

class SplashController extends GetxController {
  static SplashController get find => Get.find();
  RxBool animate = false.obs;
  final appCtrl = Get.put(AppController());

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    animate.value = true;
    await appCtrl.init();
  }
}
