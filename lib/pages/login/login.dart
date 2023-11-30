import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/pages/home/home.dart';
import 'package:survey_io/bloc/login/login_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_passcode.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/models/auth/auth_request_model.dart';
import 'package:survey_io/pages/register/register_phone_number.dart';

// Import Component
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
  TextEditingController phoneNumber = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  TextEditingController passcode = TextEditingController();
  FocusNode passcodeFocus = FocusNode();

  String gender = '';
  bool _hidePasscode = true;
  bool isLogged = false;
  bool isExpiredToken = false;

  var presscount = 0;

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
    phoneNumberFocus.unfocus();
    passcodeFocus.unfocus();
  }

  bool _validateForm() {
    if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your phone number',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (passcode.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Passcode',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
    return true;
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
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelTextLogin(),
            CustomDividers.smallDivider(),
            formInputField(),
            labelTextPassword(),
            CustomDividers.extraLargeDivider(),
            CustomDividers.largeDivider(),
            CustomDividers.extraLargeDivider(),
            BlocProvider(
              create: (context) => LoginBloc(),
              child: buttonSubmit(),
            ),
            CustomDividers.smallDivider(),
            textSignUpHere(),
            CustomDividers.verySmallDivider(),
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
        style: TextStyles.h2(color: AppColors.secondary),
      ),
    );
  }

  Widget labelTextPassword() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
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
          labelText: 'No. Telepon',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.smallDivider(),
        TextInputField(
          focusNode: phoneNumberFocus,
          keyboardType: TextInputType.phone,
          controller: phoneNumber,
          hintText: 'Masukkan Nomor telepon',
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
          hintText: 'Passcode',
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
                  if (_validateForm()) {
                    final requestModel = AuthRequestModel(
                        phoneNumber: phoneNumber.text,
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
              text: 'Belum Punya Akun ?',
              style: TextStyles.h4(color: AppColors.secondary)),
          TextSpan(
            text: ' Daftar di sini',
            style: TextStyles.h4(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
          ),
        ],
      ),
    );
  }
}
