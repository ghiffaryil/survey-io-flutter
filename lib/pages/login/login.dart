import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/request_otp/request_otp_bloc.dart';
import 'package:survey_io/common/constants/function/show_toast.dart';
import 'package:survey_io/common/constants/function/validate_form.dart';
import 'package:survey_io/common/constants/function/validate_form_passcode.dart';
import 'package:survey_io/common/constants/function/validate_form_phone_number.dart';
import 'package:survey_io/common/constants/padding.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/pages/email_verification/email_verification_otp.dart';
import 'package:survey_io/pages/forgot_passcode/forgot_passcode_by_email.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:survey_io/bloc/login/login_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_passcode.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/models/auth/auth_request_model.dart';
import 'package:survey_io/pages/register/register_by_email_complete.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';
import '../../common/components/divider.dart';
import '../../common/components/label.dart';
import '../../common/components/appbar_plain.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inputPhoneNumber = TextEditingController();
  FocusNode inputPhoneNumberFocus = FocusNode();

  TextEditingController inputEmail = TextEditingController();
  FocusNode inputEmailFocus = FocusNode();

  TextEditingController inputPasscode = TextEditingController();
  FocusNode inputPasscodeFocus = FocusNode();

  bool _hideinputPasscode = true;
  bool isLogged = false;
  bool isExpiredToken = false;

  String _loginTypeValue = 'Email';

  @override
  void initState() {
    super.initState();
  }

  void _showHideinputPasscodeTogle() {
    setState(() {
      _hideinputPasscode = !_hideinputPasscode;
    });
  }

  void unfocusAll() {
    inputPhoneNumberFocus.unfocus();
    inputPasscodeFocus.unfocus();
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
    return false;
  }

  bool _validatePasscodeForm() {
    return validateForm(
      inputPasscode.text,
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
            // labelTextPasscode(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.23,
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
          focusNode: inputPasscodeFocus,
          controller: inputPasscode,
          hintText: 'Masukkan 6 Digit Angka',
          hidePassword: _hideinputPasscode,
          onPasswordVisibilityToggle: _showHideinputPasscodeTogle,
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
            error: (msg) {
              if (msg == "email not verified") {
                // Show email verification dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return showDialogEmailVerification(inputEmail.text);
                  },
                );
              } else if (msg == "record not found") {
                showToast(message: 'Silahkan login menggunakan Email');
              } else {
                showToast(message: msg);
              }
            });
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Login',
                onPressed: () {
                  print('Login by $_loginTypeValue');

                  if (_loginTypeValue == "Phone") {
                    if (validateLoginTypeForm(_loginTypeValue) &&
                        _validatePasscodeForm()) {
                      // print('Phone : ${inputPhoneNumber.text}');
                      final requestModel = AuthRequestModel.withPhoneNumber(
                          phoneNumber: inputPhoneNumber.text,
                          pin: inputPasscode.text,
                          firebaseToken: '32jr982jd9137asd2',
                          platform: 'android',
                          deviceId: '123xcv');
                      context
                          .read<LoginBloc>()
                          .add(LoginEvent.login(requestModel));
                    }
                  } else {
                    if (validateLoginTypeForm(_loginTypeValue) &&
                        _validatePasscodeForm()) {
                      // print('Email : ${inputEmail.text}');
                      final requestModel = AuthRequestModel.withEmail(
                          email: inputEmail.text,
                          pin: inputPasscode.text,
                          firebaseToken: '32jr982jd9137asd2',
                          platform: 'android',
                          deviceId: '123xcv');
                      context
                          .read<LoginBloc>()
                          .add(LoginEvent.login(requestModel));
                    }
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

  Widget showDialogEmailVerification(email) {
    return BlocListener<RequestOtpBloc, RequestOtpState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return EmailVerificationOtpPage(inputEmail: inputEmail.text);
              }));
            },
            error: (msg) {
              showToast(message: msg);
            });
      },
      child: BlocBuilder<RequestOtpBloc, RequestOtpState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Perhatian!',
                    style: TextStyles.h3(color: AppColors.primary),
                  ),
                ),
                content: Text(
                  'Anda belum melakukan verifikasi email',
                  textAlign: TextAlign.center,
                  style: TextStyles.h5(color: AppColors.secondary),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Batal',
                      style: TextStyles.regular(color: AppColors.primary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<RequestOtpBloc>()
                          .add(RequestOtpEvent.requestOtp(inputEmail.text));
                    },
                    child: Container(
                      padding: CustomPadding.p1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: AppColors.primary),
                      child: Text(
                        'Verifikasi Sekarang',
                        style: TextStyles.regular(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            loading: () {
              return AlertDialog(
                surfaceTintColor: AppColors.white,
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mengirim verifikasi',
                    style: TextStyles.h3(color: AppColors.primary),
                  ),
                ),
                content: SizedBox(
                  height: 100,
                  width: 100,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )),
                ),
              );
            },
          );
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
                  _loginTypeValue = 'Email'; //Next Login Type
                  inputEmail.clear();
                  inputPasscode.clear();
                });
              } else if (_loginTypeValue == "Email") {
                setState(() {
                  _loginTypeValue = 'Phone'; //Next Login Type
                  inputPhoneNumber.clear();
                  inputPasscode.clear();
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
