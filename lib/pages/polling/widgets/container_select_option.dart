import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';

class SelectOptionContainer extends StatelessWidget {
  final String pilihan;
  final bool isActive;

  const SelectOptionContainer({
    Key? key,
    required this.pilihan,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      pilihan,
      textAlign: TextAlign.center,
      style: TextStyles.regular(
          color: isActive ? Colors.white : AppColors.secondary,
          fontWeight: FontWeight.w700),
    );
  }
}
