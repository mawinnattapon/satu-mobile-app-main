import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/config.dart';
import 'package:satu/constants/app.init.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/library/loading.dart';
import 'package:satu/styles/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: Config.appname,
        navigatorKey: Get.key,
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.getPages,
        debugShowCheckedModeBanner: false,
        // translations: AppLanguages(),
        builder: Loading.init,
        initialBinding: AppInit(),
        transitionDuration: const Duration(milliseconds: 500),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('th'),
        localizationsDelegates: const [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
        // supportedLocales: const [
        //   Locale('th'),
        //   Locale('en'),
        // ],
        // navigatorObservers: <NavigatorObserver>[
        // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        // GetObserver()
        // ],
        theme: AppTheme.themeData,
      );
    });
  }
}
