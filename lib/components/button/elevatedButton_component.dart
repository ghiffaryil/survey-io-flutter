import 'package:flutter/material.dart';
import 'package:survey_io/components/color/color_component.dart';

class ElevatedButtonPrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonPrimary({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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

class ElevatedButtonSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color textColor;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonSecondary({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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

class ElevatedButtonInfo extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonInfo({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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

class ElevatedButtonWarning extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonWarning({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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

class ElevatedButtonOutlinePrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonOutlinePrimary({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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

class ElevatedButtonOutlineSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final double minWidth; // Dynamic minimum width
  final double height; // Dynamic height
  final double fontSize; // Dynamic font size
  final FontWeight fontWeight; // Dynamic font weight
  final VoidCallback onPressed;

  const ElevatedButtonOutlineSecondary({
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
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
