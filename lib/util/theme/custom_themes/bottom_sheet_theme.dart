import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/colors.dart';

class CBottomSheetTheme {
  CBottomSheetTheme._();
//* for light bottom sheet theme
  static BottomSheetThemeData lightBottomSheetThemeData = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: CColors.white,
    modalBackgroundColor: CColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
//* for dark bottom sheet theme
  static BottomSheetThemeData darkBottomSheetThemeData = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: CColors.black,
    modalBackgroundColor: CColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
