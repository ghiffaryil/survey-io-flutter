import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:survey_io/pages/login/login.dart';

import '../../../common/components/elevated_button.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/information_card.dart';
import '../../../common/constants/padding.dart';
import 'register_verification_otp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneNumber = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();

  void unfocusAll() {
    phoneNumberFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: CustomPadding.pdefault,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelText(),
              CustomDividers.smallDivider(),
              formInputField(),
              CustomDividers.smallDivider(),
              buildNoticeSection(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              CustomDividers.smallDivider(),
              buildButtonSubmit(),
              CustomDividers.smallDivider(),
              buildTextSignInHere(),
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Daftar',
        style: TextStyles.h2(color: AppColors.secondary),
      ),
    );
  }

  Widget formInputField() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '1. Masukkan Nomor Telepon',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        TextInputField(
          focusNode: phoneNumberFocus,
          keyboardType: TextInputType.phone,
          controller: phoneNumber,
          hintText: '0812345678910',
        ),
      ],
    );
  }

  Widget buildNoticeSection() {
    return const NoticeInformation(
      icon: 'assets/images/information/warning_info.svg',
      iconType: 'svg',
      information:
          'Nomor telepon tidak dapat diubah setelah akun dibuat. Pastikan nomor telepon kamu terkoneksi dengan WhatsApp',
    );
  }

  Widget buildButtonSubmit() {
    return ButtonFilled.primary(
        text: 'Daftar',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VerificationOTP()));
        });
  }

  Widget buildTextSignInHere() {
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
