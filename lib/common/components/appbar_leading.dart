import 'package:flutter/material.dart';

class LeadingHeader extends StatelessWidget {
  final double iconSize;
  final VoidCallback onPressed;
  final Color textColor;
  final IconData? leadingIcon;

  const LeadingHeader({
    super.key,
    required this.iconSize,
    required this.onPressed,
    required this.textColor,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          leadingIcon ?? Icons.arrow_back_ios,
          color: textColor,
          size: iconSize,
        ));
  }
}
