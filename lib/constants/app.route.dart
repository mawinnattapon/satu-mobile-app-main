import 'package:get/get.dart';
import 'package:satu/screens/checklists.screen.dart';
import 'package:satu/screens/forgot.screen.dart';
import 'package:satu/screens/privacy.screen.dart';
import 'package:satu/screens/signup.screen.dart';
import 'package:satu/screens/systeminfo/completed.screen.dart';
import 'package:satu/screens/qrscanner.screen.dart';
import 'package:satu/screens/splash.screen.dart';
import 'package:satu/screens/systeminfo/step.system.screen.dart';
import 'package:satu/screens/systeminfo/system.info.screen.dart';
import 'package:satu/screens/user/change.pwd.screen.dart';
import 'package:satu/screens/user/login.screen.dart';

class AppRoutes {
  AppRoutes._();
  static String splashScreen = "/";

  static String loginScreen = "/user/login";
  static String changePwd = "/user/change_pwd";

  static String signup = "/signup";
  static String forGotScreen = "/forgot";

  static String qrScannerScreen = "/QRScanner";

  static String checklistsScreen = "/Checklists";

  static String systemInfoScreen = "/systemInfo";
  static String stepSystemScreen = "/systemInfo/stepSystem";

  static String completedScreen = "/systemInfo/completed";

  static String privacy = "/privacy";

  static final getPages = [
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: qrScannerScreen,
      page: () => const QRScannerScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: checklistsScreen,
      page: () => const ChecklistsScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: systemInfoScreen,
      page: () => const SystemInfoScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: stepSystemScreen,
      page: () => const StepSystemScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: completedScreen,
      page: () => const CompletedScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: changePwd,
      page: () => const ChangePwdScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: forGotScreen,
      page: () => const ForgotPwdScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      transition: Transition.cupertinoDialog,
      transitionDuration: 500.milliseconds,
      name: privacy,
      page: () => const PrivacyScreen(),
    ),
  ];
}
