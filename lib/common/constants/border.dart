import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

class AppBorder {
  static BorderSide defaultBorder = const BorderSide(
    color: AppColors.secondary,
    width: 1.0,
  );

  static BorderSide normalBorder = const BorderSide(
    color: AppColors.secondary,
    width: 2.0,
  );

  static BorderSide bigBorder = const BorderSide(
    color: AppColors.secondary,
    width: 3.0,
  );
}
