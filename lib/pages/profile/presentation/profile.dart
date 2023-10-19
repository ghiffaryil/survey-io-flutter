import 'package:flutter/material.dart';
import 'package:survey_io/pages/profile/presentation/widgets/list_menu.dart';
import 'package:survey_io/pages/profile/presentation/widgets/profile_information.dart';
import 'package:survey_io/pages/profile/presentation/widgets/profile_not_found.dart';

import '../../../common/components/appbar.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../../tabs/floating_icon.dart';
import '../../tabs/navigation_bottom_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 2;

  bool isLogged = true;

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
      body: isLogged
          ? const Column(
              children: [
                UserInformation(),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListMenu(),
                  ),
                ),
              ],
            )
          : const ProfileNotFound(),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }
}
