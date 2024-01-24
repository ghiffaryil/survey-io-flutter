import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/constants/function/show_toast.dart';
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
import 'package:survey_io/pages/register/register_by_email_complete.dart';

// Import Component
import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';
import '../../common/components/divider.dart';
import '../../common/components/label.dart';
import '../../common/components/appbar_plain.dart';

class LoginOldPage extends StatefulWidget {
  const LoginOldPage({super.key});

  @override
  State<LoginOldPage> createState() => _LoginOldPageState();
}

class _LoginOldPageState extends State<LoginOldPage> {
  TextEditingController inputPhoneNumber = TextEditingController();
  FocusNode inputPhoneNumberFocus = FocusNode();
  TextEditingController passcode = TextEditingController();
  FocusNode passcodeFocus = FocusNode();

  bool _hidePasscode = true;
  bool isLogged = false;
  bool isExpiredToken = false;

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

  bool _validateFormPhoneNumber() {
    return validateForm(
      inputPhoneNumber.text,
      validatePhoneNumberForm,
      'Masukkan Nomor Handphone kamu',
      isPhone: true,
    );
  }

  bool _validatePasscodeForm() {
    return validateForm(
      passcode.text,
      validatePasscodeForm,
      'Masukkan Passcode kamu',
      isPhone: true,
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
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelTextLogin(),
            CustomDividers.verySmallDivider(),
            formInputField(),
            labelTextPassword(),
            // CustomDividers.extraLargeDivider(),
            // CustomDividers.extraLargeDivider(),
            // CustomDividers.regularDivider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.245,
            ),
            BlocProvider(
              create: (context) => LoginBloc(),
              child: buttonSubmit(),
            ),
            CustomDividers.smallDivider(),
            textSignUpHere(),
            CustomDividers.regularDivider(),
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

  Widget labelTextPassword() {
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

  Widget formInputField() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Selamat datang kembali di Survei.io',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
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
            error: (msg) {
              showToast(message: msg);
            });
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Login',
                onPressed: () {
                  if (_validateFormPhoneNumber() && _validatePasscodeForm()) {
                    final requestModel = AuthRequestModel.withPhoneNumber(
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
                        builder: (context) =>
                            const RegisterByEmailCompletePage()));
              },
          ),
        ],
      ),
    );
  }
}