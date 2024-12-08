import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';

class COutlineButtonTheme {
  COutlineButtonTheme._();
  // * for light oultine button theme

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: CColors.black,
      side: const BorderSide(color: CColors.primaryColor),
      textStyle: const TextStyle(
          fontSize: 16,
          color: CColors.textPrimary,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  //* for dark oultine button theme

  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: CColors.white,
      side: const BorderSide(color: CColors.primaryColor),
      textStyle: const TextStyle(
          fontSize: 16,
          color: CColors.textPrimary,
          fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
