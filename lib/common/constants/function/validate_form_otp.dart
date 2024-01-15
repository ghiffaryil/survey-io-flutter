// common/constants/functions/validate_form_otp.dart

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

bool validateOtpForm(List<TextEditingController> controllers) {
  if (controllers.any((controller) => controller.text.isEmpty)) {
    // Show FlutterToast indicating that OTP input is empty
    Fluttertoast.showToast(
      msg: 'Harap masukkan kode OTP',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.secondary.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return false;
  } else {
    return true;
  }
}
