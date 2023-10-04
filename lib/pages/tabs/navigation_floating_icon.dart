import 'package:flutter/material.dart';
import 'package:survey_io/pages/survey/presentation/create_survey.dart';

class NavigationFloatingIcon extends StatelessWidget {
  final bool isActive;

  const NavigationFloatingIcon({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    String imageAsset = 'assets/icons/rewards_icon.png';

    if (isActive == true) {
      imageAsset = 'assets/icons/rewards_icon_focused.png';
    }

    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BuatSurvei()));
        },
        tooltip: 'Buat Survei',
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16), // Adjust the radius as needed
        ),
        child: Image.asset(
          imageAsset,
          width: 50,
        ),
      ),
    );
  }
}
