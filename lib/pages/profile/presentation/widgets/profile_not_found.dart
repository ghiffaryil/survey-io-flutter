// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/pages/login/presentation/login.dart';
import 'package:survey_io/pages/onboarding/presentation/onboarding.dart';

// Import Component
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/components/divider.dart';

import '../../../../common/constants/imageSize.dart';
import '../../../../common/constants/images.dart';

class ProfileNotFound extends StatefulWidget {
  const ProfileNotFound({super.key});

  @override
  State<ProfileNotFound> createState() => _ProfileNotFoundState();
}

class _ProfileNotFoundState extends State<ProfileNotFound> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      body: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDividers.smallDivider(),
            Image.asset(Images.emptyAccount,
                width: AppSizeHeight.imageSize(context, AppSizeHeight.medium)),
            CustomDividers.smallDivider(),
            Text(
              'Ups, akun tidak ditemukan \n Yuk buat akun kamu sekarang!',
              textAlign: TextAlign.center,
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
            CustomDividers.largeDivider(),
            buttonSubmit(),
            CustomDividers.smallDivider(),
            textSignInHere(),
            CustomDividers.smallDivider(),
          ],
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return ButtonFilled.primary(
        text: 'Daftar',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OnboardingPage()));
        });
  }

  Widget textSignInHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Sudah Punya Akun ?',
              style: TextStyles.h5(color: AppColors.secondary)),
          TextSpan(
            text: ' Login di sini',
            style: TextStyles.h5(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
          ),
        ],
      ),
    );
  }
}
