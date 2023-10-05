import '../constants/colors.dart';
import 'package:flutter/material.dart';

class PlainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final double height;
  final double toolbarHeight;
  final IconData? leadingIcon;
  final Color textColor;
  final double iconSize;

  const PlainAppBar({
    required this.onPressed,
    this.height = 56,
    this.toolbarHeight = 56,
    required this.leadingIcon,
    required this.iconSize,
    required this.textColor,
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
            color: textColor,
            size: iconSize,
          )),
      toolbarHeight: height,
      backgroundColor: AppColors.white,
    );
  }
}
