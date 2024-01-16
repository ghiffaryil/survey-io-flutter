import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/colors.dart';

bool validatePasscodeForm(String passcode) {
  passcode = passcode.trim();

  if (passcode.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Masukkan passcode kamu',
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
