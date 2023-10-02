import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String textHeader;
  final TextStyle labelStyle;

  const TitleHeader({
    super.key,
    required this.textHeader,
    required this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textHeader,
      style: labelStyle,
    );
  }
}
