import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/constants/function/validate_form.dart';
import 'package:survey_io/common/constants/function/validate_form_passcode.dart';
import 'package:survey_io/common/constants/function/validate_form_phone_number.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/pages/forgot_passcode/forgot_passcode_by_email.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:survey_io/bloc/login/login_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_passcode.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/models/auth/auth_request_model.dart';
import 'package:survey_io/pages/register/register_by_email.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';
import '../../common/components/divider.dart';
import '../../common/components/label.dart';
import '../../common/components/appbar_plain.dart';

class LoginMultiplePage extends StatefulWidget {
  const LoginMultiplePage({super.key});

  @override
  State<LoginMultiplePage> createState() => _LoginMultiplePageState();
}

class _LoginMultiplePageState extends State<LoginMultiplePage> {
  TextEditingController inputPhoneNumber = TextEditingController();
  FocusNode inputPhoneNumberFocus = FocusNode();

  TextEditingController inputEmail = TextEditingController();
  FocusNode inputEmailFocus = FocusNode();

  TextEditingController passcode = TextEditingController();
  FocusNode passcodeFocus = FocusNode();

  bool _hidePasscode = true;
  bool isLogged = false;
  bool isExpiredToken = false;

  String _loginTypeValue = 'Email';

  @override
  void initState() {
    super.initState();
  }

  void _showHidePasscodeTogle() {
    setState(() {
      _hidePasscode = !_hidePasscode;
    });
  }

  void unfocusAll() {
    inputPhoneNumberFocus.unfocus();
    passcodeFocus.unfocus();
  }

  bool validateLoginTypeForm(String loginTypeValue) {
    if (loginTypeValue == "Email") {
      return validateForm(
        inputEmail.text,
        (value) => true,
        'Masukkan Email kamu',
        isEmail: true,
      );
    } else if (loginTypeValue == "Phone") {
      return validateForm(
        inputPhoneNumber.text,
        validatePhoneNumberForm,
        isPhone: true,
        'Masukkan Nomor Handphone kamu',
      );
    }

    return false; // Add additional cases as needed
  }

  bool _validatePasscodeForm() {
    return validateForm(
      passcode.text,
      validatePasscodeForm,
      'Masukkan Passcode kamu',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelTextLogin(),
            CustomDividers.verySmallDivider(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selamat datang kembali di Survei.io',
                style: TextStyles.h4(color: AppColors.secondary),
              ),
            ),
            CustomDividers.verySmallDivider(),
            animatedToggle(),
            formInputField(),
            labelTextPasscode(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
            ),
            BlocProvider(
              create: (context) => LoginBloc(),
              child: buttonSubmit(),
            ),
            CustomDividers.smallDivider(),
            textSignUpHere(),
          ],
        ),
      ),
    );
  }

  Widget labelTextLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Login',
        style: TextStyles.h1(color: AppColors.secondary),
      ),
    );
  }

  Widget formInputField() {
    return Column(
      children: [
        _loginTypeValue == "Email"
            ? Column(
                children: [
                  // LOGIN BY EMAIL
                  LabelInput(
                    labelText: 'Email',
                    labelStyle: TextStyles.h4(color: AppColors.secondary),
                  ),
                  CustomDividers.smallDivider(),
                  TextInputField(
                    focusNode: inputEmailFocus,
                    keyboardType: TextInputType.emailAddress,
                    controller: inputEmail,
                    hintText: 'Masukkan Email Kamu',
                  ),
                ],
              )
            : Column(
                //  LOGIN BY PHONE
                children: [
                  LabelInput(
                    labelText: 'Nomor Handphone',
                    labelStyle: TextStyles.h4(color: AppColors.secondary),
                  ),
                  CustomDividers.smallDivider(),
                  TextInputField(
                    focusNode: inputPhoneNumberFocus,
                    keyboardType: TextInputType.phone,
                    controller: inputPhoneNumber,
                    hintText: 'Masukkan Nomor Handphone',
                  ),
                ],
              ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Passcode',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        PasscodeTextInput(
          focusNode: passcodeFocus,
          controller: passcode,
          hintText: 'Masukkan 6 Digit Angka',
          hidePassword: _hidePasscode,
          onPasswordVisibilityToggle: _showHidePasscodeTogle,
        ),
      ],
    );
  }

  Widget labelTextPasscode() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ForgotPasscodeByEmail()),
          );
        },
        child: Text(
          'Lupa Password?',
          style: TextStyles.regular(color: AppColors.info),
        ),
      ),
    );
  }

  Widget buttonSubmit() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              AuthLocalGuestDatasource().removeAuthData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
            error: (message) {
              Fluttertoast.showToast(
                  msg: message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.secondary.withOpacity(0.8),
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Login',
                onPressed: () {
                  print('Login by $_loginTypeValue');
                  if (validateLoginTypeForm(_loginTypeValue) &&
                      _validatePasscodeForm()) {
                    final requestModel = AuthRequestModel(
                        phoneNumber: inputPhoneNumber.text,
                        pin: passcode.text,
                        firebaseToken: '32jr982jd9137asd2',
                        platform: 'android',
                        deviceId: '123xcv');
                    context
                        .read<LoginBloc>()
                        .add(LoginEvent.login(requestModel));
                  }
                });
          }, loading: () {
            return ButtonFilled.primary(
                textColor: AppColors.white,
                text: '',
                loading: true,
                onPressed: () {});
          });
        },
      ),
    );
  }

  Widget textSignUpHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Belum Punya Akun?',
              style: TextStyles.h4(color: AppColors.secondary)),
          TextSpan(
            text: ' Daftar di sini',
            style: TextStyles.h4(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterByEmailPage()));
              },
          ),
        ],
      ),
    );
  }

  Widget animatedToggle() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: MediaQuery.of(context).size.width * 0.10,
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_loginTypeValue == "Phone") {
                setState(() {
                  _loginTypeValue = 'Email';
                  inputEmail.text = "";
                });
              } else if (_loginTypeValue == "Email") {
                setState(() {
                  _loginTypeValue = 'Phone';
                  inputPhoneNumber.text = "";
                });
              }
              print(_loginTypeValue);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.10,
              decoration: ShapeDecoration(
                color: AppColors.secondary.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  2,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: Text(_loginTypeValue == "Phone" ? 'Email' : 'Phone',
                        textAlign: TextAlign.center,
                        style: TextStyles.medium(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: _loginTypeValue == "Email"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.width * 0.10,
              decoration: ShapeDecoration(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _loginTypeValue,
                textAlign: TextAlign.center,
                style: TextStyles.medium(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
