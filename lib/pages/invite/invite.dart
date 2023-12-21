// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/components/shimmer_card.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/pages/profile/widgets/profile_not_found.dart';

import '../../bloc/profile/get_profile/profile_bloc.dart';
import '../../common/components/appbar_plain.dart';
import '../../common/constants/icons.dart';
import '../../common/constants/images.dart';
import '../../common/constants/padding.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  int selectedIndex = 2;
  bool isLogged = false;
  bool isGuest = false;
  String refferalCode = '';

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void loadDataSource() {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  void checkToken() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();

    // IF TOKEN IS EMPTY
    if (token.isEmpty) {
      // IF GUEST TOKEN NOT EMPTY
      if (guestToken.isNotEmpty) {
        setState(() {
          isGuest = true;
          isLogged = false;
        });
        loadDataSource();
      } else {}
    } else {
      // Have User Token
      setState(() {
        isGuest = false;
        isLogged = true;
      });
      loadDataSource();
    }
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void copyTextToClipboard(String copy) {
    Clipboard.setData(ClipboardData(text: copy));

    Fluttertoast.showToast(
      msg: 'Teks berhasil disalin : $copy',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.secondary.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onShare(BuildContext context, String reffCode) {
    print('refferalCode $refferalCode');
    Share.share(
        'Mau ikut survei singkat dan dapat hadiah? Daftarkan akun kamu di aplikasi Survei.io dengan menggunakan kode referal: $reffCode. Download Survei.io https://play.google.com/store/apps/details?id=io.survei.android sekarang!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: isLogged
          ? Container(
              padding: CustomPadding.pdefault,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Container();
                    },
                    loading: () {
                      return Column(
                        children: [
                          LabelInput(
                              labelText: 'Undang Teman',
                              labelStyle:
                                  TextStyles.h2(color: AppColors.secondary)),
                          const ShimmerInvite(),
                        ],
                      );
                    },
                    loaded: (data) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LabelInput(
                              labelText: 'Undang Teman',
                              labelStyle:
                                  TextStyles.h2(color: AppColors.secondary)),
                          CustomDividers.regularDivider(),
                          ImageInvitation(),
                          CustomDividers.smallDivider(),
                          TextInformationReferal(),
                          CustomDividers.smallDivider(),
                          ReferalCode(data.user.refcode),
                          CustomDividers.smallDivider(),
                          TextInformation(),
                          CustomDividers.regularDivider(),
                          buttonInviteFriend(data.user.refcode),
                        ],
                      );
                    },
                  );
                },
              ),
            )
          : const ProfileNotFound(),
    );
  }

  Widget ImageInvitation() {
    return Image.asset(
      Images.inviteFriend,
      width: MediaQuery.of(context).size.width * 0.4,
    );
  }

  Widget ReferalCode(String refferalCode) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: AppColors.primary.withOpacity(0.05),
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                refferalCode,
                style: TextStyles.h4(
                  color: AppColors.secondary,
                ),
              )),
          GestureDetector(
            onTap: () {
              copyTextToClipboard(refferalCode);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppColors.primary),
              child: Row(
                children: [
                  Image.asset(
                    IconName.copyContent,
                    width: 17,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Copy',
                    style: TextStyles.medium(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget TextInformationReferal() {
    return Text(
      'Dapatkan 100 koin dengan mengundang teman melalui kode referal',
      textAlign: TextAlign.center,
      style: TextStyles.extraLarge(color: AppColors.secondary),
    );
  }

  Widget TextInformation() {
    return Text(
      'Bagikan kode referal kamu atau tekan tombol “Undang Teman” di bawah ini',
      textAlign: TextAlign.center,
      style: TextStyles.large(color: AppColors.secondary),
    );
  }

  Widget buttonInviteFriend(String refferalCode) {
    return ButtonFilled.primary(
        text: 'Undang Teman',
        onPressed: () {
          _onShare(context, refferalCode);
        });
  }
}
