// common/constants/functions/merge_value_otp.dart

import 'package:flutter/material.dart';

String mergeOtpValue(List<TextEditingController> controllers) {
  return controllers.sublist(0, 4).fold('',
      (String previousValue, TextEditingController controller) {
    return previousValue + controller.text;
  });
}
