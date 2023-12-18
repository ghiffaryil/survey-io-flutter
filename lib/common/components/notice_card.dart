import 'package:flutter/material.dart';
import 'package:survey_io/common/constants/images.dart';

import '../constants/colors.dart';
import '../constants/styles.dart';
import 'divider.dart';

class NoticeCard extends StatelessWidget {
  final String text;
  final String textLink;
  final String link;

  const NoticeCard(
      {super.key, required this.text, this.textLink = '', this.link = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.notice, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
                child: Image.asset(
              Images.notice,
              width: 45.0,
            )),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyles.medium(color: AppColors.secondary),
                ),
                CustomDividers.smallDivider(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    textLink,
                    style: TextStyles.regular(
                      color: AppColors.info,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
