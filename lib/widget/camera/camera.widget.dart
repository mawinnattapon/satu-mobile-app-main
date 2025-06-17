import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CameraWidget extends StatefulWidget {
  final void Function(XFile) onPressed;
  const CameraWidget({super.key, required this.onPressed});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  bool _cameraInitialized = false;

  late List<CameraDescription> _cameras;
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _cameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraInitialized && controller.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(controller),
            ),
            Positioned(
              right: 3.h,
              top: 5.h,
              bottom: 5.h,
              child: InkWell(
                onTap: () async {
                  try {
                    XFile image = await controller.takePicture();
                    widget.onPressed(image);
                    Get.back();
                  } catch (_) {}
                },
                child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 5.h,
                    )),
              ),
            ),
            Positioned(
              left: 2.h,
              top: 5.h,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 3.h,
                    )),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
