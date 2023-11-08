// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/profile/profile.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';

import '../../bloc/profile/profile_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  void copyTextToClipboard(String copy) {
    Clipboard.setData(ClipboardData(text: copy));

    Fluttertoast.showToast(
      msg: 'Teks berhasil disalin : $copy',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.light.withOpacity(0.3),
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
      body: Container(
        padding: CustomPadding.pdefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LabelInput(
                labelText: 'Undang Teman',
                labelStyle: TextStyles.h2(color: AppColors.secondary)),
            CustomDividers.regularDivider(),
            ImageInvitation(),
            CustomDividers.smallDivider(),
            TextInformationReferal(),
            CustomDividers.smallDivider(),
            ReferalCode(),
            CustomDividers.smallDivider(),
            TextInformation(),
            CustomDividers.regularDivider(),
            buttonInviteFriend(),
          ],
        ),
      ),
    );
  }

  Widget ImageInvitation() {
    return Image.asset(
      Images.inviteFriend,
      width: MediaQuery.of(context).size.width * 0.4,
    );
  }

  Widget ReferalCode() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: AppColors.primary.withOpacity(0.05),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return Container();
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }, error: (message) {
            return Container(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                ));
          }, loaded: (data) {
            return Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      data.user.refcode,
                      style: TextStyles.h4(
                        color: AppColors.secondary,
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    copyTextToClipboard(data.user.refcode);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: AppColors.primary),
                    child: Row(
                      children: [
                        Image.asset(
                          IconName.copyContent,
                          width: 20,
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
            ));
          });
        },
      ),
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

  Widget buttonInviteFriend() {
    return ButtonFilled.primary(
        text: 'Undang Teman',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
        });
  }
}
