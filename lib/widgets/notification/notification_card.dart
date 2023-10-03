import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/models/notification/model_notification.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

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
            width: 0.3, // Choose the border width
          ),
        ),
      ),
      child: Text(notification.title,
          style: notification.clicked
              ? TextStyles.regular(color: AppColors.secondaryLightColor)
              : TextStyles.regular(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor)),
    );
  }
}
