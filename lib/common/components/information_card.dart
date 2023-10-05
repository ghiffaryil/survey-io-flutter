import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:survey_io/common/constants/styles.dart';

import '../constants/colors.dart';

class NoticeInformation extends StatelessWidget {
  final String information;
  final String icon;
  final String iconType;

  const NoticeInformation(
      {super.key,
      required this.icon,
      required this.iconType,
      required this.information});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Center(
                child: iconType == 'svg'
                    ? SvgPicture.asset(icon)
                    : Image.asset(icon),
              )),
          Expanded(
            flex: 8,
            child: Text(
              information,
              style: TextStyles.small(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
