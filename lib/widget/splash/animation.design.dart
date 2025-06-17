import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satu/models/app/splash.model.dart';
import 'package:satu/modules/controller/splash.ctrl.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    Key? key,
    required this.durationInMs,
    this.animationPosition,
    required this.child,
  }) : super(key: key);

  final controller = Get.put(SplashController());
  final int durationInMs;
  final TAnimationPosition? animationPosition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? animationPosition!.topAfter : animationPosition!.topBefore,
        left: controller.animate.value ? animationPosition!.leftAfter : animationPosition!.leftBefore,
        bottom: controller.animate.value ? animationPosition!.bottunAfter : animationPosition!.bottunBefore,
        right: controller.animate.value ? animationPosition!.righAfter : animationPosition!.righBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animate.value ? 1 : 0,
          child: child,
        ),
      ),
    );
  }
}
