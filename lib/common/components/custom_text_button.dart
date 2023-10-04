import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

class TextButtonPrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonPrimary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.primaryColor,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
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

class TextButtonSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color textColor;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonSecondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.secondaryColor,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
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
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextButtonInfo extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonInfo({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.infoColor,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
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

class TextButtonWarning extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonWarning({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.warningColor,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
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
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextButtonOutlinePrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonOutlinePrimary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = Colors.white,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextButtonOutlineSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const TextButtonOutlineSecondary({
    super.key,
    required this.text,
    this.rounded = true,
    this.backgroundColor = Colors.white,
    this.minWidth = 30, // Default minimum width
    this.height = 60, // Default height
    this.fontSize = 17, // Default font size
    this.fontWeight = FontWeight.bold, // Default font weight
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * minWidth, height),
        side: const BorderSide(color: AppColors.secondaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
