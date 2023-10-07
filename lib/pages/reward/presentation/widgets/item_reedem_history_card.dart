import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/pages/reward/models/reedem_history_mdel.dart';

class ReedemHistoryCard extends StatelessWidget {
  final ReedemHistoryModel data;

  const ReedemHistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Choose your desired border color
            width: 0.2, // Choose the border width
          ),
        ),
      ),
      child: Text(data.message,
          style: data.clicked
              ? TextStyles.regular(color: AppColors.light)
              : TextStyles.regular(
                  fontWeight: FontWeight.bold, color: AppColors.secondary)),
    );
  }
}
