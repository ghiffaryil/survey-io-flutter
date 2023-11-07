// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/profile/profile_bloc.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/pages/profile/widgets/profile_menu.dart';
import 'package:survey_io/pages/profile/widgets/profile_information.dart';
import 'package:survey_io/pages/profile/widgets/profile_not_found.dart';

import '../../../common/components/appbar.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../../datasources/login/auth_local_datasource.dart';
import '../tabs/floating_icon.dart';
import '../tabs/navigation_bottom_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 2;
  bool isLogged = true;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  // Function to check the login status
  void checkLoginStatus() async {
    final token = await AuthLocalDatasource().getToken();
    if (token.isEmpty) {
      setState(() {
        isLogged = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

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
                    child: ListMenuProfile(),
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
