import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/components/list_menu.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/pages/invite/presentation/invite.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/pages/tabs/navigation_floating_icon.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/tabs/navigation_bottom_bar.dart';
import 'package:survey_io/pages/home/presentation/home.dart';
import '../../../common/components/appbar.dart';
import '../../../common/constants/images.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: MainAppBar(
        height: 70.0,
        toolbarHeight: 70.0,
        title: Text(
          'Akun',
          style: TextStyles.h2ExtraBold(
            color: AppColors.white,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            userInformation(),
            listMenu(),
            CustomDividers.smallDivider(),
            versionInformation(),
            CustomDividers.smallDivider(),
            buttonLogout(),
            CustomDividers.mediumDivider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }

  Widget userInformation() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 20),
      width: double.infinity,
      // height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: AppColors.primary,
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
              IconName.account,
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
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0812321312312',
                    style: TextStyles.regular(color: AppColors.secondary),
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
                      color: AppColors.primary,
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
                        Image.asset(Images.iconCheck)
                      ],
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget listMenu() {
    return Column(
      children: [
        CustomDividers.verySmallDivider(),
        HorizontalMenu(
          imageAsset: IconName.editProfile,
          text: 'Edit Profile',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const EditProfile()));
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.inviteFriend,
          text: 'Invite Friend',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InviteFriend()));
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        CustomDividers.verySmallDivider(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: LabelInput(
              labelText: 'Other Info',
              labelStyle: TextStyles.h4(color: AppColors.secondary)),
        ),
        HorizontalMenu(
          imageAsset: IconName.helper,
          text: 'Pusat Bantuan',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            // Your onPressed logic here
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.privacypolicy,
          text: 'Kebijakan Privasi',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            // Your onPressed logic here
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.tnc,
          text: 'Ketentuan Layanan',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            // Your onPressed logic here
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.rating,
          text: 'Beri Rating',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            // Your onPressed logic here
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
      ],
    );
  }

  Widget versionInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          'Ver.1.0.0',
          textAlign: TextAlign.right,
          style: TextStyles.muted(color: AppColors.secondary.withOpacity(0.3)),
        ),
      ),
    );
  }

  Widget buttonLogout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextButtonOutlined.secondary(
          text: 'Logout',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }),
    );
  }
}
