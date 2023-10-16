import 'package:flutter/material.dart';

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
