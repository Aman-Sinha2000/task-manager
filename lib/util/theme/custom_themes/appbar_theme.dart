import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';

class CAppBarTheme {
  CAppBarTheme._();
  //* for light app bar theme
  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: CColors.black, size: 24),
      actionsIconTheme: IconThemeData(color: CColors.black, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: CColors.black));
  //* for dark app bar theme
  static const darkAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: CColors.black, size: 24),
      actionsIconTheme: IconThemeData(color: CColors.white, size: 24),
      titleTextStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: CColors.white));
}
