import 'package:flutter/material.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/components/list_menu.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';
import '../../../invite/presentation/invite.dart';
import '../../../login/presentation/login.dart';
import '../edit_profile.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDividers.verySmallDivider(),
        HorizontalMenu(
          imageAsset: IconName.editProfile,
          text: 'Edit Profile',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            Navigator.push(context,
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
            Navigator.push(context,
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
        CustomDividers.smallDivider(),
        versionInformation(),
        CustomDividers.smallDivider(),
        buttonLogout(),
        CustomDividers.mediumDivider(),
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
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }),
    );
  }
}
