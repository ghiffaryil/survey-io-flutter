import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

class ButtonFilled extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final Color textColor;
  final double minWidth;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final bool loading;

  const ButtonFilled.primary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.primary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.secondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.secondary,
    this.textColor = AppColors.secondary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.success({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.success,
    this.textColor = AppColors.success,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.info({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.info,
    this.textColor = AppColors.info,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.warning({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.warning,
    this.textColor = AppColors.warning,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.light({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.light,
    this.textColor = AppColors.light,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.white({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primary,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  const ButtonFilled.custom({
    super.key,
    required this.text,
    this.rounded = true,
    required this.backgroundColor,
    required this.textColor,
    this.minWidth = 30,
    this.height = 60,
    this.fontSize = 17,
    this.fontWeight = FontWeight.bold,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: loading
          ? SizedBox(
              height: minWidth,
              width: minWidth,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 3,
                ),
              ),
            )
          : Text(
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

class ButtonOutlined extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color borderColor;
  final Color textColor;
  final double minWidth;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool loading;

  const ButtonOutlined.primary({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.secondary({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.warning({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.info({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.success({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.light({
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
    this.loading = false,
    this.backgroundColor = AppColors.white,
  });

  const ButtonOutlined.white({
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
    this.loading = false,
    this.backgroundColor = AppColors.bg,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: loading
          ? CircularProgressIndicator(
              color: textColor,
            )
          : Text(
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
