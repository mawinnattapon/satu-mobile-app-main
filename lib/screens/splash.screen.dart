import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/splash.model.dart';
import 'package:satu/modules/controller/splash.ctrl.dart';
import 'package:satu/widget/splash/animation.design.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashCtrl = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashCtrl.startSplashAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1200,
            animationPosition: TAnimationPosition(
              bottunAfter: 0,
              bottunBefore: -100,
              leftAfter: 0,
              leftBefore: 0,
              topAfter: 0,
              topBefore: 0,
              righAfter: 0,
              righBefore: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/logo/logo.svg'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
