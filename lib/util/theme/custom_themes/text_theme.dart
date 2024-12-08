import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';

class CTextTheme {
  CTextTheme._();

  //* for light text theme

  static TextTheme lightTextTheme = TextTheme(
    //for headlines
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32, fontWeight: FontWeight.w700, color: CColors.textPrimary),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.w600, color: CColors.textPrimary),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w400, color: CColors.textPrimary),

    //for title
    titleLarge: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: CColors.textPrimary),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, color: CColors.textPrimary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, color: CColors.textPrimary),

    //for body
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: CColors.textPrimary),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: CColors.textPrimary),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: CColors.textPrimary.withOpacity(0.5),
    ),

    //for label
    labelLarge: const TextStyle().copyWith(
        fontSize: 12, fontWeight: FontWeight.w700, color: CColors.textPrimary),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: CColors.textPrimary.withOpacity(0.5)),
  );

  //* for dark text theme

  static TextTheme darkTextTheme = TextTheme(
    //for headlines
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32, fontWeight: FontWeight.w700, color: CColors.textWhite),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.w600, color: CColors.textWhite),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w400, color: CColors.textWhite),

    //for title
    titleLarge: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, color: CColors.textWhite),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, color: CColors.textWhite),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, color: CColors.textWhite),

    //for body
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w700, color: CColors.textWhite),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: CColors.textWhite),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: CColors.textWhite.withOpacity(0.5),
    ),

    //for label
    labelLarge: const TextStyle().copyWith(
        fontSize: 12, fontWeight: FontWeight.w700, color: CColors.textWhite),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: CColors.textWhite.withOpacity(0.5)),
  );
}
