import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_io/components/button/button_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/views/register/verification_otp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController PhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.secondaryColor,
            )),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text Daftar
            LabelText(),
            // Input Phone Number
            InputPhoneNumber(),
            // Info Phone Number
            NoticeInformation(),
            // Divider
            CustomDividers.extraLargeDivider(),
            // Divider
            CustomDividers.extraLargeDivider(),
            // Button
            ButtonDaftar(),
            // Text
            TextSignInHere(),
          ],
        ),
      ),
    );
  }

  Widget LabelText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Daftar',
        style: TextStyles.h2(color: AppColors.secondaryColor),
      ),
    );
  }

  Widget InputPhoneNumber() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '1. Masukkan Nomor Telepon',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        CustomDividers.smallDivider(),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: '0812345678910',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
      ],
    );
  }

  Widget NoticeInformation() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.infoColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Center(
                  child: SvgPicture.asset(
                      'assets/images/information/warning-info.svg'))),
          Expanded(
            flex: 8,
            child: Text(
              'Nomor telepon tidak dapat diubah setelah akun dibuat. Pastikan nomor telepon kamu terkoneksi dengan WhatsApp',
              style: TextStyles.small(color: AppColors.secondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget ButtonDaftar() {
    return ButtonPrimary(
        text: 'Daftar',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VerificationOTP()));
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
