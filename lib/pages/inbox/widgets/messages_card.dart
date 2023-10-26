import 'package:survey_io/common/components/image_rounded.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/common/extension/helper/date_helper.dart';
import 'package:survey_io/models/messages/messages_model.dart';
import 'package:flutter/material.dart';

class MessagesCard extends StatelessWidget {
  final MessagesModel messages;

  late final String dateString; // Declare as late
  late final DateTime date; // Declare as late

  MessagesCard({super.key, required this.messages}) {
    dateString = messages.createdAt;
    date = DateTime.parse(dateString);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = date.formatDateId();

    return Container(
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: messages.clicked ? AppColors.white : AppColors.bg,
        border: const Border(
          bottom: BorderSide(
            color: AppColors.light,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: CustomPadding.px1,
            child: RoundedImage(
              imageUrl: messages.image,
              imageType: 'network',
              height: 120,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: CustomPadding.px1,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  messages.title,
                  textAlign: TextAlign.left,
                ),
                Text(
                  messages.description,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  formattedDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
