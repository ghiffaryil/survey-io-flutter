import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';

class RadioTextInput extends StatelessWidget {
  final String value;
  final String selectedOption; // Add this variable to store the selected gender
  final ValueChanged<String> onChanged; // Add this callback to handle changes
  final bool editable;

  const RadioTextInput({
    Key? key,
    required this.value,
    required this.selectedOption, // Pass the selected gender
    required this.onChanged, // Pass the callback
    this.editable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: !editable
              ? AppColors.secondary.withOpacity(0.4)
              : selectedOption == value
                  ? AppColors.secondary
                  : AppColors.secondary.withOpacity(0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              value,
              style: TextStyles.extraLarge(
                color: !editable
              ? AppColors.secondary.withOpacity(0.4)
              : selectedOption == value
                    ? AppColors.secondary
                    : AppColors.secondary.withOpacity(0.4),
              ),
            ),
          ),
          Radio(
            activeColor: AppColors.primary,
            value: value,
            groupValue:
                selectedOption, // Use the selected gender as group value
            onChanged: (newValue) {
              onChanged(newValue!); // Call the callback to handle changes
            },
          ),
        ],
      ),
    );
  }
}
