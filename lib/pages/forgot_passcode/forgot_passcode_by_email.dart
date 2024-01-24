import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/function/show_toast.dart';
import 'package:survey_io/common/constants/function/validate_form.dart';
import 'package:survey_io/pages/email_verification/email_verification_otp.dart';
import 'package:survey_io/bloc/forgot_pasccode/forgot_passcode_request_otp/forgot_passcode_request_otp_bloc.dart';
import 'package:survey_io/pages/login/login.dart';

// Import Component
import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';
import '../../common/components/divider.dart';
import '../../common/components/label.dart';
import '../../common/components/appbar_plain.dart';

class ForgotPasscodeByEmail extends StatefulWidget {
  const ForgotPasscodeByEmail({super.key});

  @override
  State<ForgotPasscodeByEmail> createState() => _ForgotPasscodeByEmailState();
}

class _ForgotPasscodeByEmailState extends State<ForgotPasscodeByEmail> {
  TextEditingController inputEmail = TextEditingController();
  FocusNode inputEmailFocus = FocusNode();

  bool isLogged = false;
  bool isExpiredToken = false;

  @override
  void initState() {
    super.initState();
  }

  void unfocusAll() {
    inputEmailFocus.unfocus();
  }

  bool _validateFormEmail() {
    return validateForm(
      inputEmail.text,
      (value) => true,
      'Masukkan Email kamu',
      isEmail: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlainAppBar(
        leadingIcon: Icons.arrow_back_ios,
        iconColor: AppColors.secondary,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const LoginPage();
          }));
        },
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            labelText(),
            CustomDividers.verySmallDivider(),
            formInputField(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.52,
            ),
            BlocProvider(
              create: (context) => ForgotPasscodeRequestOtpBloc(),
              child: buttonSubmit(),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Lupa Password',
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
            '1. Pulihkan akun kamu',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Email',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.smallDivider(),
        TextInputField(
          focusNode: inputEmailFocus,
          keyboardType: TextInputType.emailAddress,
          controller: inputEmail,
          hintText: 'Masukkan Email',
        ),
      ],
    );
  }

  Widget buttonSubmit() {
    return BlocListener<ForgotPasscodeRequestOtpBloc,
        ForgotPasscodeRequestOtpState>(
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
      child: BlocBuilder<ForgotPasscodeRequestOtpBloc,
          ForgotPasscodeRequestOtpState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
              text: 'Kirim OTP',
              onPressed: () {
                if (_validateFormEmail()) {
                  context.read<ForgotPasscodeRequestOtpBloc>().add(
                      ForgotPasscodeRequestOtpEvent.requestOtp(
                          inputEmail.text));
                }
              },
            );
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
}