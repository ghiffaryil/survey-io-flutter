import 'package:flutter/material.dart';
import 'package:survey_io/pages/inbox/presentation/inbox.dart';
import 'package:survey_io/pages/profile/presentation/profile.dart';
import 'package:survey_io/pages/reedem/presentation/reedem.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/padding.dart';
import '../../../../common/constants/styles.dart';

class FloatingProfileCard extends StatelessWidget {
  const FloatingProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Center(
        child: Padding(
          padding: CustomPadding.pdefault,
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()),
                              );
                            },
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
                        ),
                      ],
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Image.asset(
                            IconName.point,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReedemPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '0',
                                  style: TextStyles.h4(
                                    color: AppColors.secondary,
                                  ),
                                ),
                                Text(
                                  'Celengan Saya',
                                  style: TextStyles.regular(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
