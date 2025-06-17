import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:satu/constants/app.colors.dart';

class ImageView extends StatelessWidget {
  final String url;
  const ImageView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        PhotoView(
          backgroundDecoration: const BoxDecoration(color: AppColor.dark),
          imageProvider: NetworkImage(url),
          minScale: 0.5,
        ),
        Positioned(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () => Get.back(),
                child: const Icon(Icons.close, size: 32),
              ),
            ),
          ),
        )
      ],
    );
  }
}
