// ignore_for_file: non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/button/elevated_button_component.dart';
import 'package:survey_io/components/navigation/navigation_floating_icon.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/navigation/navigation_bottom_bar.dart';
import 'package:survey_io/views/profile/profile.dart';

class PreRegister extends StatefulWidget {
  const PreRegister({super.key});

  @override
  State<PreRegister> createState() => _PreRegisterState();
}

class _PreRegisterState extends State<PreRegister> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8fbff),
      appBar: AppBar(
        toolbarHeight: 100.0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Akun',
          style: TextStyles.h2(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDividers.smallDivider(),
            Container(
              child: Image.asset(
                'assets/images/icons/empty_akun_image.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            CustomDividers.smallDivider(),
            Container(
              child: Text(
                'Ups, akun tidak ditemukan \n Yuk buat akun kamu sekarang!',
                textAlign: TextAlign.center,
                style: TextStyles.extraLarge(color: AppColors.secondaryColor),
              ),
            ),
            CustomDividers.largeDivider(),
            ButtonSubmit(),
            CustomDividers.smallDivider(),
            TextSignInHere(),
            CustomDividers.smallDivider(),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: NavigationFloatingIcon(
        isActive: false,
      ),
    );
  }

  Widget ButtonSubmit() {
    return ElevatedButtonPrimary(
        text: 'Daftar',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Profile()));
        });
  }

  Widget TextSignInHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Sudah Punya Akun ?',
              style: TextStyles.h5(color: AppColors.secondaryColor)),
          TextSpan(
            text: ' Login di sini',
            style: TextStyles.h5(color: AppColors.primaryColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('OK');
              },
          ),
        ],
      ),
    );
  }
}