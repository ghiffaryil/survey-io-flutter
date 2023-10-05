import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/notification/presentation/notification.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/navigation_floating_icon.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/common/components/divider.dart';

import '../../../common/components/appbar.dart';
import '../../../common/constants/icons.dart';
import '../../../common/constants/images.dart';

class BuatSurvei extends StatefulWidget {
  const BuatSurvei({super.key});

  @override
  State<BuatSurvei> createState() => _BuatSurveiState();
}

class _BuatSurveiState extends State<BuatSurvei> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: MainAppBar(
        title: Text(
          'Buat Survei',
          style: TextStyles.h2ExtraBold(
            color: AppColors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationPage(),
            ),
          );
        },
        icon: const Icon(Icons.notifications),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          buildPositionedMainSection(),
          buildRedShapeSection(),
          buildProfileSection(),
        ]),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: true,
      ),
    );
  }

  Widget buildPositionedMainSection() {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          // MARGIN TOP
          Container(height: MediaQuery.of(context).size.height * 0.15),
          CustomDividers.smallDivider(),
          Image.asset(
            Images.emptyCreateSurvey,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          CustomDividers.smallDivider(),
          Text(
            'Ups, kamu belum punya survei nih \n Yuk buat survei kamu sekarang!',
            textAlign: TextAlign.center,
            style: TextStyles.extraLarge(color: AppColors.secondary),
          ),
          CustomDividers.smallDivider(),
          buildButtonSubmit(),
          CustomDividers.smallDivider(),
        ]),
      ),
    );
  }

  Widget buildIconSection() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                // CustomDividers.smallDivider(),
                Image.asset(
                  IconName.survey,
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Survei',
                    style: TextStyles.h5(color: AppColors.secondary)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // CustomDividers.smallDivider(),
                Image.asset(
                  IconName.polling,
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Polling',
                    style: TextStyles.h5(color: AppColors.secondary)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // CustomDividers.smallDivider(),
                Image.asset(
                  IconName.invite,
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Invite',
                    style: TextStyles.h5(color: AppColors.secondary)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRedShapeSection() {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          color: AppColors.primary,
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }

  Widget buildProfileSection() {
    return Positioned(
      top: null,
      right: null,
      bottom: null,
      left: null,
      child: Center(
        child: Padding(
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
                                style:
                                    TextStyles.h4(color: AppColors.secondary),
                              ),
                              Text(
                                'Profile Saya',
                                style: TextStyles.regular(
                                    color: AppColors.secondary),
                              ),
                            ],
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
                            IconName.totalSurvey,
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
                                '0',
                                style:
                                    TextStyles.h4(color: AppColors.secondary),
                              ),
                              Text(
                                'Jumlah Survei',
                                style: TextStyles.regular(
                                    color: AppColors.secondary),
                              ),
                            ],
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

  Widget buildButtonSubmit() {
    return ButtonFilled.primary(
        text: 'Buat Survei',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
  }
}
