import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_io/common/components/custom_elevated_button.dart';
import 'package:survey_io/common/components/form_input_text.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/widgets/global/appbar_leading.dart';
import 'package:survey_io/widgets/global/custom_divider.dart';

// Page
import 'register_verification_otp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController PhoneNumber = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();

  void unfocusAll() {
    phoneNumberFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: LeadingHeader(
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
            },
            textColor: AppColors.secondaryColor,
            leadingIcon: Icons.arrow_back_ios, // Pass the icon data here
          )),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelText(),
            FormInputField(),
            NoticeInformation(),
            CustomDividers.extraLargeDivider(),
            CustomDividers.extraLargeDivider(),
            ButtonSubmit(),
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

  Widget FormInputField() {
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
        TextInputField(
          focusNode: phoneNumberFocus,
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          hintText: '0812345678910',
          // prefixIcon: Icon(Icons.person), // Set prefix icon
          // suffixIcon: Icon(Icons.person), // Set suffix icon
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

  Widget ButtonSubmit() {
    return ElevatedButtonPrimary(
        text: 'Daftar',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VerificationOTP()));
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
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
