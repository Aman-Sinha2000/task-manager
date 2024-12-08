import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';

class CElevatedButtonTheme {
  CElevatedButtonTheme._(); //SingleTon Class to avoid creating instances
  //* for light color button theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: CColors.white,
      backgroundColor: CColors.buttonPrimary,
      disabledBackgroundColor: CColors.buttonDisabled,
      disabledForegroundColor: CColors.buttonDisabled,
      side: const BorderSide(color: CColors.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: CColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
  //* for dark color button theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: CColors.white,
      backgroundColor: CColors.buttonPrimary,
      disabledBackgroundColor: CColors.buttonDisabled,
      disabledForegroundColor: CColors.buttonDisabled,
      side: const BorderSide(color: CColors.darkGrey),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: CColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
