import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckbox({super.key, 
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: value
            ? const Icon(
                Icons.square,
                size: 15.0,
                color: AppColors.primary,
              )
            : Container(),
      ),
    );
  }
}
