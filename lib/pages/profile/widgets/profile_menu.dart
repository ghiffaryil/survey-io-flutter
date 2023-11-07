import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/bloc/logout/logout_bloc.dart';
import 'package:survey_io/datasources/login/auth_local_datasource.dart';

import '../../../../common/components/divider.dart';
import '../../../../common/components/label.dart';
import '../../../../common/components/list_menu.dart';
import '../../../../common/components/text_button.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/constants/icons.dart';
import '../../../../common/constants/styles.dart';
import '../../../common/components/elevated_button.dart';
import '../../../common/constants/widgets/indicator.dart';
import '../../invite/invite.dart';
import '../../login/login.dart';
import '../edit_profile.dart';

class ListMenuProfile extends StatefulWidget {
  const ListMenuProfile({super.key});

  @override
  State<ListMenuProfile> createState() => _ListMenuProfileState();
}

class _ListMenuProfileState extends State<ListMenuProfile> {
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
    return BlocProvider(
      create: (context) => LogoutBloc(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                loaded: () {
                  AuthLocalDatasource().removeAuthData();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                error: () {
                  Fluttertoast.showToast(
                      msg: 'Login Error',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.light.withOpacity(0.3),
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
          },
          builder: (context, state) => state.maybeWhen(orElse: () {
            return TextButtonOutlined.secondary(
                backgroundColor: AppColors.bg,
                text: 'Logout',
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                });
          }, loaded: () {
            return Center(
              child: Container(),
            );
          }),
        ),
      ),
    );
  }

  void showModalLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            children: [
              const IndicatorModal(),
              CustomDividers.regularDivider(),
              const Text(
                'Anda yakin ingin keluar dari aplikasi ini?',
                style: TextStyle(fontSize: 18),
              ),
              CustomDividers.regularDivider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonOutlined.primary(
                      text: 'Batal',
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonFilled.primary(
                      text: 'Keluar',
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
