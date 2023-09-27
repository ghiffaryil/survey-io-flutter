import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/button/text_button_component.dart';
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/menu/menu_horizontal.dart';
import 'package:survey_io/components/navigation/navigation_floating_icon.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/navigation/navigation_bottom_bar.dart';
import 'package:survey_io/views/home/home.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({super.key});

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: AppBar(
        toolbarHeight: 70.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Akun',
          style: TextStyles.h2ExtraBold(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountInformation(),
            ListMenu(),
            CustomDividers.smallDivider(),
            TextVersionInfo(),
            CustomDividers.smallDivider(),
            ButtonLogout(),
            CustomDividers.mediumDivider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }

  Widget AccountInformation() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 20),
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/account_icon.png',
              width: 45,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fahmi Fauzi',
                    style: TextStyles.extraLarge(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0812321312312',
                    style: TextStyles.regular(color: AppColors.secondaryColor),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Verified',
                          style: TextStyles.h5(color: Colors.white),
                        ),
                        Image.asset('assets/images/icons/check_verified.png')
                      ],
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget ListMenu() {
    return Container(
      child: Column(
        children: [
          CustomDividers.verySmallDivider(),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/editprofile_icon.png',
            text: 'Edit Profile',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Edit Profile');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/invitefriend_icon.png',
            text: 'Invite Friend',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Invite Friend');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
          CustomDividers.verySmallDivider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LabelInput(
                labelText: 'Other Info',
                labelStyle: TextStyles.h4(color: AppColors.secondaryColor)),
          ),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/helpcenter_icon.png',
            text: 'Pusat Bantuan',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Help');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/privacypolicy_icon.png',
            text: 'Kebijakan Privasi',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Privasi');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/tnc_icon.png',
            text: 'Ketentuan Layanan',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Ketentuan');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
          HorizontalMenu(
            imageAsset: 'assets/images/icons/rating_icon.png',
            text: 'Beri Rating',
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              // Your onPressed logic here
              print('Beri Rating');
            },
            iconColor: AppColors.secondaryLightColor,
            textColor: AppColors.secondaryLightColor,
          ),
        ],
      ),
    );
  }

  Widget TextVersionInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Ver.1.0.0',
          textAlign: TextAlign.right,
          style: TextStyles.muted(
              color: AppColors.secondaryColor.withOpacity(0.3)),
        ),
      ),
    );
  }

  Widget ButtonLogout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextButtonOutlineSecondary(
          text: 'Logout',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }),
    );
  }
}
