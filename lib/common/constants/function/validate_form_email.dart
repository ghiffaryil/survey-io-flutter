import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/colors.dart';

bool validateEmailForm(String email) {
  email = email.trim();

  if (email.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Masukkan Email kamu',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.secondary.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return false;
  }

  // Regular expression for a simple email validation
  RegExp emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  if (!emailRegExp.hasMatch(email)) {
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

  return true;
}
