// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_io/common/components/custom_elevated_button.dart';
import 'package:survey_io/common/components/custom_text_button.dart';

// Import Component
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/pages/profile/presentation/profile.dart';
import 'package:survey_io/widgets/global/appbar_leading.dart';
import 'package:survey_io/widgets/global/custom_divider.dart';
import 'package:survey_io/widgets/global/label_input.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  int selectedIndex = 2;
  final String textToCopy = 'FAHM2345';

  // Function to copy text to clipboard
  void copyTextToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       'Text copied to clipboard: $textToCopy',
    //       style: TextStyles.medium(color: Colors.white),
    //     ),
    //     backgroundColor: AppColors.primaryColor,
    //   ),
    // );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Text Copied'),
            content: Text(textToCopy),
            actions: [
              Container(
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextButtonOutlinePrimary(
                    text: 'Ok',
                    minWidth: 10,
                    height: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingHeader(
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: AppColors.secondaryColor,
          leadingIcon: Icons.arrow_back_ios, // Pass the icon data here
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelInput(
                labelText: 'Undang Teman',
                labelStyle: TextStyles.h2(color: AppColors.secondaryColor)),
            CustomDividers.smallDivider(),
            ImageInvitation(),
            CustomDividers.smallDivider(),
            TextInformationReferal(),
            CustomDividers.smallDivider(),
            ReferalCode(),
            CustomDividers.smallDivider(),
            TextInformation(),
            CustomDividers.smallDivider(),
            buttonInviteFriend(),
            CustomDividers.smallDivider(),
          ],
        ),
      ),
    );
  }

  Widget ImageInvitation() {
    return Image.asset(
      'assets/images/icons/invitefriends_icon.png',
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
          color: AppColors.primaryColor.withOpacity(0.05)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'FAHM2345',
                style: TextStyles.h4(
                  color: AppColors.secondaryColor,
                ),
              )),
          GestureDetector(
            onTap: () {
              copyTextToClipboard(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppColors.primaryColor),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/icons/content_copy_icon.png',
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
      )),
    );
  }

  Widget TextInformationReferal() {
    return Text(
      'Dapatkan 100 koin dengan mengundang teman melalui kode referal',
      textAlign: TextAlign.center,
      style: TextStyles.extraLarge(color: AppColors.secondaryColor),
    );
  }

  Widget TextInformation() {
    return Text(
      'Bagikan kode referal kamu atau tekan tombol “Undang Teman” di bawah ini',
      textAlign: TextAlign.center,
      style: TextStyles.large(color: AppColors.secondaryColor),
    );
  }

  Widget buttonInviteFriend() {
    return ElevatedButtonPrimary(
        text: 'Undang Teman',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
        });
  }
}
