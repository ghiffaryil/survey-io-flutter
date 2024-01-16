import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/colors.dart';

bool validateForm(
  String input,
  bool Function(String) validationFunction,
  String errorMessage, {
  bool isEmail = false,
  bool isPhone = false,
}) {
  input = input.trim();

  if (input.isEmpty) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.secondary.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return false;
  }

  if (isEmail) {
    // Regular expression for a simple email validation
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegExp.hasMatch(input)) {
      Fluttertoast.showToast(
        msg: 'Masukkan Email yang valid',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  if (isPhone) {
    // Regular expression for phone number (numeric only)
    RegExp phoneRegExp = RegExp(
      r'^[0-9]+$',
    );

    if (!phoneRegExp.hasMatch(input)) {
      Fluttertoast.showToast(
        msg: 'Masukkan Nomor yang valid',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  return validationFunction(input);
}
