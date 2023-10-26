import 'package:flutter/material.dart';
import '../colors.dart';

class IndicatorModal extends StatelessWidget {
  const IndicatorModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.indicator,
        ),
        height: 5,
      ),
    );
  }
}
