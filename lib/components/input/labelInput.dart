import 'package:flutter/material.dart';

class LabelInput extends StatelessWidget {
  final String labelText;
  final TextStyle labelStyle;

  LabelInput({
    required this.labelText,
    required this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        labelText,
        style: labelStyle,
      ),
    );
  }
}
