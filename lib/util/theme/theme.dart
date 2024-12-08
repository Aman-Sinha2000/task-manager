import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';
import 'package:task_tracker/util/theme/custom_themes/appbar_theme.dart';
import 'package:task_tracker/util/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:task_tracker/util/theme/custom_themes/elevated_button_theme.dart';
import 'package:task_tracker/util/theme/custom_themes/outline_button_theme.dart';
import 'package:task_tracker/util/theme/custom_themes/text_field_theme.dart';
import 'package:task_tracker/util/theme/custom_themes/text_theme.dart';

class CAppTheme {
  CAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.light,
      primaryColor: CColors.primaryColor,
      scaffoldBackgroundColor: CColors.white,
      textTheme: CTextTheme.lightTextTheme,
      elevatedButtonTheme: CElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: COutlineButtonTheme.lightOutlineButtonTheme,
      inputDecorationTheme: CTextFieldTheme.lightInputDecorationTheme,
      bottomSheetTheme: CBottomSheetTheme.lightBottomSheetThemeData,
      appBarTheme: CAppBarTheme.lightAppBarTheme);
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      primaryColor: CColors.primaryColor,
      scaffoldBackgroundColor: CColors.black,
      textTheme: CTextTheme.darkTextTheme,
      elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: COutlineButtonTheme.darkOutlineButtonTheme,
      inputDecorationTheme: CTextFieldTheme.darkInputDecorationTheme,
      bottomSheetTheme: CBottomSheetTheme.darkBottomSheetThemeData,
      appBarTheme: CAppBarTheme.darkAppBarTheme);
}
