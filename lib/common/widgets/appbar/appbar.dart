import 'package:flutter/material.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/device/device_utils.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CAppBar({super.key, this.title});
  final Widget? title;
  // final bool? showBackArrow;
  // final IconData? leadingIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CSizes.sm),
      child: AppBar(
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(CDeviceUtils.getAppBarHeight());
}
