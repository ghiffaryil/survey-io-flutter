// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/guest/guest_bloc.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:survey_io/pages/profile/webview_help_center.dart';
import 'package:survey_io/pages/profile/webview_privacy_policy.dart';
import 'package:survey_io/pages/profile/webview_terms_and_condition.dart';
import 'package:survey_io/bloc/logout/logout_bloc.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/common/components/list_menu.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/icons.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/widgets/indicator.dart';
import 'package:survey_io/pages/invite/invite.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/pages/profile/edit_profile.dart';

class ListMenuProfile extends StatefulWidget {
  const ListMenuProfile({super.key});

  @override
  State<ListMenuProfile> createState() => _ListMenuProfileState();
}

class _ListMenuProfileState extends State<ListMenuProfile> {
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri.https(
      'play.google.com',
      'store/apps/details',
      {'id': 'io.survei.android'},
    );

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpCenterWebview()));
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.privacypolicy,
          text: 'Kebijakan Privasi',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyWebview()));
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.tnc,
          text: 'Ketentuan Layanan',
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsAndConditionWebview()));
          },
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        HorizontalMenu(
          imageAsset: IconName.rating,
          text: 'Beri Rating',
          icon: Icons.arrow_forward_ios,
          onPressed: () => setState(() {
            _launched = _launchInBrowser(toLaunch);
          }),
          iconColor: AppColors.light,
          textColor: AppColors.light,
        ),
        CustomDividers.smallDivider(),
        versionInformation(),
        CustomDividers.smallDivider(),
        buttonLogout(),
        const SizedBox(
          height: 30,
        )
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
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: () {
                AuthLocalDatasource().removeAuthData();
                AuthLocalDatasource().clearAuthData();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () {
              return TextButtonOutlined.secondary(
                  backgroundColor: AppColors.bg,
                  text: 'Logout',
                  onPressed: () {
                    showModalLogoutConfirmation(context);
                    // context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  });
            },
          ),
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
          height: MediaQuery.of(context).size.height * 0.30,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            children: [
              const IndicatorModal(),
              CustomDividers.smallDivider(),
              Text(
                'Anda yakin ingin keluar dari aplikasi ini?',
                style: TextStyles.medium(),
              ),
              CustomDividers.smallDivider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocListener<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        loading: () {
                          AuthLocalDatasource().removeAuthData();
                          AuthLocalDatasource().clearAuthData();
                          context
                              .read<GuestBloc>()
                              .add(const GuestEvent.getGuestToken());
                        },
                        loaded: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                      );
                    },
                    child: BlocBuilder<LogoutBloc, LogoutState>(
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return ButtonOutlined.primary(
                            text: 'Ya, Keluar',
                            onPressed: () {
                              // DO LOGOUT BLOC
                              context
                                  .read<LogoutBloc>()
                                  .add(const LogoutEvent.logout());
                            },
                          );
                        }, loading: () {
                          return ButtonOutlined.primary(
                            text: '',
                            loading: true,
                            textColor: AppColors.primary,
                            onPressed: () {},
                          );
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonFilled.primary(
                      text: 'Tidak, Batal',
                      onPressed: () {
                        Navigator.of(context).pop();
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
