import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/constants/app.images.dart';
import 'package:satu/constants/app.route.dart';
import 'package:satu/constants/app.textstyle.dart';
import 'package:satu/layout/drawer.dart';
import 'package:satu/library/button.dart';
import 'package:satu/library/input.dart';
import 'package:satu/modules/controller/scanner.ctrl.dart';
import 'package:satu/widget/app/qrscanneroverlay.wiget.dart';
import 'package:device_orientation/device_orientation.dart';

import 'dart:math' as math;

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final scannerCtrl = Get.put(ScannerController());
  final formKey = GlobalKey<FormState>();
  bool isScanCompleted = false;
  @override
  void initState() {
    super.initState();
  }

  void closeScreen() {
    isScanCompleted = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(scaffoldKey: _scaffoldKey),
      endDrawerEnableOpenDragGesture: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                buildL(context),
                buildR(context),
              ],
            ),
            SafeArea(
              child: GestureDetector(
                onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  child: Text(
                    'Settings',
                    style: AppTextStyle.b1Style(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildR(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          color: AppColor.primary,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45.h,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.white,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  'Barcode / QR Code',
                                  style: AppTextStyle.hsetStyle(
                                    colors: AppColor.black,
                                    size: 4.h,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Scan to Start',
                                  style: AppTextStyle.b3Style(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                StreamBuilder<DeviceOrientation>(
                                    stream: deviceOrientation$,
                                    initialData: deviceOrientation,
                                    builder: (context, snapshot) {
                                      double x = snapshot.data == DeviceOrientation.landscapeLeft ? 1 : -1;

                                      return Transform.rotate(
                                        angle: x * (math.pi / 2.0),
                                        // quarterTurns:
                                        //     MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 0,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 26.h,
                                            height: 26.h,
                                            child: MobileScanner(
                                              fit: BoxFit.fill,
                                              startDelay: true,
                                              // overlay: const QRScannerOverlay(
                                              //     overlayColour: AppColor.transparent),
                                              onDetect: onCapture,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                const QRScannerOverlay(overlayColour: AppColor.transparent),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  'Point your camera at the entire QR code or Barcode to start scanning.',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.b3Style(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Expanded buildL(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: AppColor.transparent,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.imageLogo,
                  fit: BoxFit.fill,
                  height: 10.h,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Enter your information',
                  style: AppTextStyle.hsetStyle(
                    colors: AppColor.black,
                    size: 4.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 50.h,
                  child: Column(
                    children: [
                      FormInput(
                        controller: scannerCtrl.codeText.value,
                        // focusNode: userCtrl.emailFocus,
                        // onSubmitted: (v) => FocusScope.of(context)
                        //     .requestFocus(userCtrl.passwordFocus),
                        title: 'Equipment ID',
                        hintText: 'Enter your equipment ID',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your equipment ID';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 3.h),
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // Loading.show();
                              FocusScope.of(context).unfocus();
                              bool isScan = await scannerCtrl.fetchQRCode(scannerCtrl.codeText.value.text.trim());
                              if (isScan) {
                                Get.toNamed(AppRoutes.checklistsScreen)!.then((value) => closeScreen());
                              } else {
                                closeScreen();
                              }
                              setState(() {});

                              // Loading.close();
                            }
                          },
                          child: Text(
                            'Proceed',
                            style: AppTextStyle.w2Style(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onCapture(BarcodeCapture capture) async {
    // Loading.show();
    if (!isScanCompleted) {
      final List<Barcode> barcodes = capture.barcodes;
      isScanCompleted = true;
      for (final barcode in barcodes) {
        debugPrint('Barcode found! ${barcode.rawValue}');
        bool isScan = await scannerCtrl.fetchQRCode(barcode.rawValue!);
        if (isScan) {
          Get.toNamed(AppRoutes.checklistsScreen)!.then((value) => closeScreen());
        } else {
          closeScreen();
        }
      }
    }
    setState(() {});
    // Loading.close();
  }
}
