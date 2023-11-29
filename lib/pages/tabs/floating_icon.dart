import 'package:flutter/material.dart';
import 'package:survey_io/pages/survey_design/survey_design_list.dart';

import '../../common/constants/icons.dart';

class NavigationFloatingIcon extends StatelessWidget {
  final bool isActive;

  const NavigationFloatingIcon({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    String imageAsset = IconName.reward;

    if (isActive == true) {
      imageAsset = IconName.rewardFocused;
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 55,
        width: 55,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SurveyDesignListPage()));
          },
          tooltip: 'Buat Survei',
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16), // Adjust the radius as needed
          ),
          child: Image.asset(
            imageAsset,
            width: 45,
          ),
        ),
      ),
    );
  }
}
