import 'package:flutter/material.dart';
import 'package:survey_io/components/color/color_component.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonPrimary({
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.primaryColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonSecondary({
    required this.text,
    this.rounded = true,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.secondaryColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ButtonInfo extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonInfo({
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.infoColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ButtonWarning extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonWarning({
    required this.text,
    this.rounded = true,
    this.backgroundColor = AppColors.warningColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ButtonOutlinePrimary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonOutlinePrimary({
    required this.text,
    this.rounded = true,
    this.backgroundColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}

class ButtonOutlineSecondary extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ButtonOutlineSecondary({
    required this.text,
    this.rounded = true,
    this.backgroundColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 30, 60),
        side: const BorderSide(color: AppColors.secondaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded ? 30.0 : 0.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
