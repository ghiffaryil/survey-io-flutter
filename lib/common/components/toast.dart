// component/alert/toast.dart

import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:flutter/material.dart';

class ToastComponent {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.secondary.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
