import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satu/config.dart';
import 'package:satu/constants/app.colors.dart';
import 'package:satu/layout/layout.main.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  //
  InAppWebViewController? webView;
  int progress = 0;
  final String url = Config.privacyUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutMain(
      title: 'Privacy & Policy',
      isSetting: false,
      backgroundColor: AppColor.light,
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(
                Uri.parse(url),
              ),
            ),
            // initialOptions: InAppWebViewGroupOptions(
            //   crossPlatform: InAppWebViewOptions(
            //     supportZoom: false,
            //     transparentBackground: true,
            //     useShouldOverrideUrlLoading: true,
            //   ),
            //   android: AndroidInAppWebViewOptions(
            //     useHybridComposition: true,
            //   ),
            // ),
            onWebViewCreated: (InAppWebViewController ctrl) => webView = ctrl,
            onProgressChanged: (InAppWebViewController ctrl, int per) {
              setState(() {
                progress = per;
              });
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: progress < 100
                  ? Container(
                      width: 100.w,
                      height: 100.h - 200,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 150,
                          height: 5,
                          color: AppColor.backgroundEmpty,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: (150 * progress) / 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColor.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
