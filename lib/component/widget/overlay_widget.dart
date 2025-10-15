import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
      padding: EdgeInsets.all(30),
      child: Center(
        child: TitleContainer(
          title: 'loading'.tr,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: AppStyle.mainGreen,
                      strokeWidth: 4,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Text(
                'pleaseWait'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.bold(
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
