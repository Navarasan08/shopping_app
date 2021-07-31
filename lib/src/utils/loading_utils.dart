import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtils {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void showLoader() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black, status: "Loading..");
  }

  static void hideLoader() {
    if (EasyLoading.isShow) EasyLoading.dismiss();
  }

  static void showToast(String msg) {
    EasyLoading.showToast(msg, toastPosition: EasyLoadingToastPosition.bottom);
  }
}