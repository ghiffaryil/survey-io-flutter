import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/colors.dart';

bool validatePhoneNumberForm(String phoneNumber) {
  phoneNumber = phoneNumber.trim();

  if (phoneNumber.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Masukkan Nomor Handphone kamu',
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
