import 'package:flutter/material.dart';

import '../constants/styles.dart';

class LabelInput extends StatelessWidget {
  final String labelText;
  final TextStyle labelStyle;
  final Alignment labelAlignment;

  const LabelInput({
    super.key,
    required this.labelText,
    required this.labelStyle,
    this.labelAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: labelAlignment,
      child: Text(
        labelText,
        style: labelStyle,
      ),
    );
  }
}

class LabelHeading extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Alignment labelAlignment;

  const LabelHeading({
    super.key,
    required this.labelText,
    required this.labelColor,
    this.labelAlignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: labelAlignment,
      child: Text(
        labelText,
        style: TextStyles.h2(color: labelColor),
      ),
    );
  }
}
