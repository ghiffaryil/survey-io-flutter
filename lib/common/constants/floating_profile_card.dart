import 'package:flutter/material.dart';
import 'package:survey_io/pages/profile/presentation/profile.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';

class FloatingProfileCard extends StatelessWidget {
  final String userFrontName;
  final Image iconImage;
  final String label;
  final int labelValue;
  final VoidCallback onPressed;

  const FloatingProfileCard({
    super.key,
    required this.userFrontName,
    required this.iconImage,
    required this.label,
    required this.labelValue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Image.asset(
                          IconName.account,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, User',
                              style: TextStyles.h4(
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              'Profile Saya',
                              style: TextStyles.regular(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: double.infinity,
                  width: 1.0,
                  color: const Color(0xFFb5b5b5),
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: onPressed,
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: iconImage),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labelValue.toString(),
                              style: TextStyles.h4(
                                color: AppColors.secondary,
                              ),
                            ),
                            Text(
                              label,
                              style: TextStyles.regular(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
