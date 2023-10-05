import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

enum ButtonStyle { primary, secondary, info, warning }

class TextButtonFilled extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const TextButtonFilled.primary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.primary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonFilled.secondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.secondary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonFilled.success({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.success,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonFilled.info({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.info,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonFilled.warning({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.warning,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonFilled.light({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.light,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextButtonOutlined extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color borderColor;
  final Color textColor;
  final double minWidth;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  const TextButtonOutlined.primary({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonOutlined.secondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.secondary,
    this.textColor = AppColors.secondary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonOutlined.warning({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.warning,
    this.textColor = AppColors.warning,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonOutlined.info({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.info,
    this.textColor = AppColors.info,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonOutlined.success({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.success,
    this.textColor = AppColors.success,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  const TextButtonOutlined.light({
    super.key,
    required this.text,
    this.rounded = true,
    this.borderColor = AppColors.light,
    this.textColor = AppColors.light,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.white,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}