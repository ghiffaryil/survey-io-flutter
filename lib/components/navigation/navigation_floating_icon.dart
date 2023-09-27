import 'package:flutter/material.dart';
import 'package:survey_io/views/account/account_profile.dart';
import 'package:survey_io/views/survei/buat_survei.dart';

class NavigationFloatingIcon extends StatelessWidget {
  final bool isActive;

  NavigationFloatingIcon({
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    String imageAsset = 'assets/images/icons/rewards_icon.png';

    if (isActive == true) {
      imageAsset = 'assets/images/icons/rewards_icon_focused.png';
    }

    return SizedBox(
      height: 60,
      width: 60,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BuatSurvei()));
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
