import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/bloc/register/request_otp/request_otp_bloc.dart';
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

  bool _validateForm() {
    if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Masukkan nomor Handphone kamu',
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
    return BlocListener<RequestOtpBloc, RequestOtpState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return VerificationOtpPage(phoneNumber: phoneNumber.text);
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
                    if (_validateForm()) {
                      context
                          .read<RequestOtpBloc>()
                          .add(RequestOtpEvent.requestOtp(phoneNumber.text));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
          ),
        ],
      ),
    );
  }
}
