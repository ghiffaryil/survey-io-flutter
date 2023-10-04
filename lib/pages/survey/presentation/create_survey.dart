import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/custom_elevated_button.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/tabs/navigation_floating_icon.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import 'package:survey_io/widgets/global/custom_divider.dart';

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
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Buat Survei',
          style: TextStyles.h2ExtraBold(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          // MAIN SECTION
          PositionedMainSection(),
          // RED BORDER RADIUS Section
          PositionedRedShapeSection(),
          // PROFILE SECTION
          PositionedProfileSection(),
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

  Widget PositionedMainSection() {
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
            'assets/images/icons/empty_buatsurvei_image.png',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          CustomDividers.smallDivider(),
          Text(
            'Ups, kamu belum punya survei nih \n Yuk buat survei kamu sekarang!',
            textAlign: TextAlign.center,
            style: TextStyles.extraLarge(color: AppColors.secondaryColor),
          ),
          CustomDividers.smallDivider(),
          ButtonSubmit(),
          CustomDividers.smallDivider(),
        ]),
      ),
    );
  }

  Widget SectionIcon() {
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
                  'assets/images/icons/icon_survey.png',
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Survei',
                    style: TextStyles.h5(color: AppColors.secondaryColor)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // CustomDividers.smallDivider(),
                Image.asset(
                  'assets/images/icons/icon_polling.png',
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Polling',
                    style: TextStyles.h5(color: AppColors.secondaryColor)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // CustomDividers.smallDivider(),
                Image.asset(
                  'assets/images/icons/icon_invite.png',
                  width: 45,
                  height: 45,
                ),
                CustomDividers.smallDivider(),
                Text('Invite',
                    style: TextStyles.h5(color: AppColors.secondaryColor)),
                // CustomDividers.smallDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget PositionedRedShapeSection() {
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
          color: AppColors.primaryColor,
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }

  Widget PositionedProfileSection() {
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
            // margin: const EdgeInsets.only(top: 5),
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
                            'assets/images/icons/account_icon.png',
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
                                    color: AppColors.secondaryColor),
                              ),
                              Text(
                                'Profile Saya',
                                style: TextStyles.regular(
                                    color: AppColors.secondaryColor),
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
                            'assets/images/icons/totalsurvei_icon.png',
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
                                style: TextStyles.h4(
                                    color: AppColors.secondaryColor),
                              ),
                              Text(
                                'Jumlah Survei',
                                style: TextStyles.regular(
                                    color: AppColors.secondaryColor),
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

  Widget ButtonSubmit() {
    return ElevatedButtonPrimary(
        text: 'Buat Survei',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        });
  }
}
