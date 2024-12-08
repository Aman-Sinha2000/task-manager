import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CDeviceUtils {
  CDeviceUtils._();

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getBottomNavigationBarHeight() => kBottomNavigationBarHeight;

  static double getAppBarHeight() => kToolbarHeight;

  static double getStatusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;
}
