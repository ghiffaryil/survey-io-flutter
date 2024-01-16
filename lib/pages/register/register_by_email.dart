import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/bloc/register/request_otp/request_otp_bloc.dart';
import 'package:survey_io/common/constants/function/validate_form.dart';
import 'package:survey_io/pages/email_verification/email_verification_otp.dart';
import 'package:survey_io/pages/login/login2.dart';
import 'package:survey_io/pages/profile/profile.dart';

import '../../../common/components/elevated_button.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/appbar_plain.dart';
import '../../../common/components/information_card.dart';
import '../../../common/constants/padding.dart';

class RegisterByEmailPage extends StatefulWidget {
  const RegisterByEmailPage({super.key});

  @override
  State<RegisterByEmailPage> createState() => _RegisterByEmailPageState();
}

class _RegisterByEmailPageState extends State<RegisterByEmailPage> {
  TextEditingController inputEmail = TextEditingController();
  FocusNode inputEmailFocus = FocusNode();

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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Profile();
          }));
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
              CustomDividers.smallDivider(),
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
            '1. Masukkan Email',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        TextInputField(
          focusNode: inputEmailFocus,
          keyboardType: TextInputType.emailAddress,
          controller: inputEmail,
          hintText: 'email@email.com',
        ),
      ],
    );
  }

  Widget buildNoticeSection() {
    return const NoticeInformation(
      icon: 'assets/images/information/warning_info.svg',
      iconType: 'svg',
      information:
          'Email tidak dapat diubah setelah akun dibuat. Pastikan Email kamu terkoneksi dengan WhatsApp',
    );
  }

  Widget buildButtonSubmit() {
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
      child: BlocBuilder<RequestOtpBloc, RequestOtpState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                  text: 'Daftar',
                  onPressed: () {
                    if (_validateFormEmail()) {
                      context
                          .read<RequestOtpBloc>()
                          .add(RequestOtpEvent.requestOtp(inputEmail.text));
                    }
                  });
            },
            loading: () {
              return ButtonFilled.primary(
                  textColor: AppColors.white,
                  text: '',
                  loading: true,
                  onPressed: () {});
            },
          );
        },
      ),
    );
  }

  Widget buildTextSignInHere() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Sudah Punya Akun?',
              style: TextStyles.h5(color: AppColors.secondary)),
          TextSpan(
            text: ' Login di sini',
            style: TextStyles.h5(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginMultiplePage()));
              },
          ),
        ],
      ),
    );
  }
}
