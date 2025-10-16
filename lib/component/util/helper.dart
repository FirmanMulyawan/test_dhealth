import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_style.dart';
import '../widget/popup_button.dart';
import '../config/app_const.dart';

class AlertModel {
  static Future<bool?> showAlert({
    required String title,
    required String message,
    String? buttonText,
    bool? barrierDismissible,
    void Function()? onClicked,
  }) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppStyle.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 17,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 25,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 30,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 20,
                    textColor: AppStyle.textColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: PopupButton(
                  onPressed: () {
                    Get.back(result: false);
                    if (onClicked != null) {
                      onClicked.call();
                    }
                  },
                  size: 50,
                  color: AppStyle.mainRed,
                  shadowColor: AppStyle.hoverRed,
                  child: Text(
                    buttonText ?? 'Ok',
                    style: AppStyle.bold(
                      size: 15,
                      textColor: AppStyle.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  static Future<bool?> showConfirmation({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    bool? barrierDismissible,
    double? confirmButtonHorizontalPadding,
    double? horizontalPadding,
    double? buttonSpacing,
  }) async {
    double horPad = horizontalPadding ?? 30;
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppStyle.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 17,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 25,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: horPad,
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 20,
                    textColor: AppStyle.textColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                  left: horPad,
                  right: horPad,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: false);
                        },
                        size: 50,
                        horizontalPadding: 0,
                        color: AppStyle.mainRed,
                        shadowColor: AppStyle.hoverRed,
                        child: Text(
                          cancelText ?? 'Cancel',
                          style: AppStyle.bold(
                            size: 15,
                            textColor: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonSpacing ?? 20,
                    ),
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
                        size: 50,
                        horizontalPadding: confirmButtonHorizontalPadding,
                        color: AppStyle.mainOrange,
                        shadowColor: AppStyle.hoverOrange,
                        child: Text(
                          confirmText ?? 'Ok',
                          textAlign: TextAlign.center,
                          style: AppStyle.bold(
                            size: 15,
                            textColor: AppStyle.whiteColor,
                          ),
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
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  static Future<bool?> showNoInternet() async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppConst.noInternetIcon),
              const SizedBox(
                height: 25,
              ),
              Text(
                'noInternetTitle'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.bold(
                  size: 24,
                  textColor: AppStyle.textColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'noInternetBody'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.regular(
                  size: 16,
                  textColor: AppStyle.textColor,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: PopupButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      size: 50,
                      color: AppStyle.mainOrange,
                      shadowColor: AppStyle.hoverOrange,
                      child: Text(
                        'tryAgain'.tr,
                        textAlign: TextAlign.center,
                        style: AppStyle.bold(
                          size: 15,
                          textColor: AppStyle.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  static Future<bool?> showCustomDialog({
    required String title,
    Widget? child,
    String? confirmText,
    String? cancelText,
    bool? barrierDismissible,
  }) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppStyle.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 17,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 25,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
              Container(child: child),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: false);
                        },
                        size: 50,
                        color: AppStyle.mainRed,
                        shadowColor: AppStyle.hoverRed,
                        child: Text(
                          cancelText ?? 'Cancel',
                          style: AppStyle.bold(
                            size: 15,
                            textColor: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
                        size: 50,
                        color: AppStyle.mainOrange,
                        shadowColor: AppStyle.hoverOrange,
                        child: Text(
                          confirmText ?? 'Ok',
                          textAlign: TextAlign.center,
                          style: AppStyle.bold(
                            size: 15,
                            textColor: AppStyle.whiteColor,
                          ),
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
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  final String title;
  final String message;

  AlertModel({this.title = "", this.message = ""});
}
