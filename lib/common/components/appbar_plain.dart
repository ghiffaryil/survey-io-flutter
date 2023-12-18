import '../constants/colors.dart';
import 'package:flutter/material.dart';

class PlainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final double height;
  final double toolbarHeight;
  final IconData? leadingIcon;
  final Color iconColor;
  final double iconSize;

  const PlainAppBar({
    required this.onPressed,
    required this.leadingIcon,
    required this.iconColor,
    this.height = 70,
    this.toolbarHeight = 70,
    this.iconSize = 30,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          onPressed: onPressed,
          icon: Icon(
            leadingIcon ?? Icons.arrow_back_ios,
            color: iconColor,
            size: iconSize,
          )),
      toolbarHeight: height,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
    );
  }
}
