import '../constants/colors.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double elevation;
  final bool implyLeading;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double height;
  final double toolbarHeight;

  const MainAppBar({
    required this.title,
    this.implyLeading = false,
    this.elevation = 0,
    this.onPressed,
    this.icon,
    this.height = 100,
    this.toolbarHeight = 100,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height); // Set the desired height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height, // Set about size icon
      elevation: elevation,
      automaticallyImplyLeading: implyLeading,
      backgroundColor: AppColors.primary,
      title: title,
      actions: [
        if (onPressed != null &&
            icon !=
                null) // Show actions if both onPressed and icon are provided
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: onPressed,
              icon: icon!,
            ),
          )
      ],
    );
  }
}

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double elevation;
  final bool implyLeading;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double height;
  final double toolbarHeight;

  const SecondaryAppBar({
    required this.title,
    this.implyLeading = false,
    this.elevation = 0,
    this.onPressed,
    this.icon,
    this.height = 100,
    this.toolbarHeight = 100,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height); // Set the desired height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height, // Set about size icon
      elevation: elevation,
      leading: IconButton(
        onPressed: onPressed,
        icon: icon!,
      ),
      automaticallyImplyLeading: implyLeading,
      backgroundColor: AppColors.primary,
      title: title,
    );
  }
}
