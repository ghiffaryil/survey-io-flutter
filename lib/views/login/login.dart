import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:survey_io/components/button/elevated_button_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/header/leading.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/input/input_text.dart';
import 'package:survey_io/views/home/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController PhoneNumber = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  TextEditingController Password = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  String JenisKelamin = '';
  bool _hidePassword = true;

  void _showHidePasswordTogle() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void unfocusAll() {
    phoneNumberFocus.unfocus();
    passwordFocus.unfocus();
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
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelTextLogin(),
            FormInputField(),
            LabelTextForgotPassword(),
            CustomDividers.extraLargeDivider(),
            CustomDividers.largeDivider(),
            ButtonLogin(),
            CustomDividers.verySmallDivider(),
            TextSignUpHere(),
            CustomDividers.verySmallDivider(),
          ],
        ),
      ),
    );
  }

  Widget LabelTextLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Login',
        style: TextStyles.h2(color: AppColors.secondaryColor),
      ),
    );
  }

  Widget LabelTextForgotPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          print('Forgot Password');
        },
        child: Text(
          'Forgot Password',
          style: TextStyles.regular(color: AppColors.infoColor),
        ),
      ),
    );
  }

  Widget FormInputField() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Selamat datang kembali di Survei.io',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        CustomDividers.smallDivider(),
        Container(
          child: LabelInput(
            labelText: 'No. Telepon',
            labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
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
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Password',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        PasswordTextInput(
          focusNode: passwordFocus,
          controller: Password,
          hintText: 'Password',
          hidePassword: _hidePassword,
          onPasswordVisibilityToggle: _showHidePasswordTogle,
        ),
      ],
    );
  }

  Widget ButtonLogin() {
    return ElevatedButtonPrimary(
        text: 'Login',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
  }

  Widget TextSignUpHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Belum Punya Akun ?',
              style: TextStyles.h4(color: AppColors.secondaryColor)),
          TextSpan(
            text: ' Daftar di sini',
            style: TextStyles.h4(color: AppColors.primaryColor),
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
