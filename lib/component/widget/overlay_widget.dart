import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart' as sizer;

import '../config/app_style.dart';
import 'title_container.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
          sizer.Device.screenType == sizer.ScreenType.mobile ? 30 : 45),
      child: Center(
        child: TitleContainer(
          title: 'loading'.tr,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: sizer.Device.screenType == sizer.ScreenType.mobile
                    ? 30
                    : 45,
              ),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: sizer.Device.screenType == sizer.ScreenType.mobile
                        ? 50
                        : 75,
                    width: sizer.Device.screenType == sizer.ScreenType.mobile
                        ? 50
                        : 75,
                    child: CircularProgressIndicator(
                      color: AppStyle.mainGreen,
                      strokeWidth:
                          sizer.Device.screenType == sizer.ScreenType.mobile
                              ? 4
                              : 10,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height:
                  sizer.Device.screenType == sizer.ScreenType.mobile ? 30 : 45,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizer.Device.screenType == sizer.ScreenType.mobile
                    ? 30
                    : 45,
              ),
              child: Text(
                'pleaseWait'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.bold(
                  size: sizer.Device.screenType == sizer.ScreenType.mobile
                      ? 15
                      : 20,
                ),
              ),
            ),
            SizedBox(
              height:
                  sizer.Device.screenType == sizer.ScreenType.mobile ? 30 : 45,
            ),
          ],
        ),
      ),
    );
  }
}

void showLoading() {
  Get.context?.loaderOverlay.show(
    widgetBuilder: (_) {
      return OverlayWidget();
    },
  );
}

void hideLoading() {
  Get.context?.loaderOverlay.hide();
}
