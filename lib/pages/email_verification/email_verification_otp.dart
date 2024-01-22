import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_io/bloc/verify_otp/verify_otp_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/function/merge_value_otp.dart';
import 'package:survey_io/common/constants/function/show_toast.dart';
import 'package:survey_io/common/constants/function/validate_form_otp.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/datasources/otp/request_otp_email.dart';
import 'package:survey_io/pages/login/login.dart';

import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/padding.dart';

class EmailVerificationOtpPage extends StatefulWidget {
  final String inputEmail;

  const EmailVerificationOtpPage({
    super.key,
    required this.inputEmail,
  });

  @override
  State<EmailVerificationOtpPage> createState() =>
      _EmailVerificationOtpPageState();
}

class _EmailVerificationOtpPageState extends State<EmailVerificationOtpPage> {
  String otpCode = '';

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _otpInputControllers =
      List.generate(6, (_) => TextEditingController());

  int _secondsRemaining = 59; // Initial value for the countdown timer
  bool _timerActive = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].dispose();
      _otpInputControllers[i].dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timerActive = false;
          _timer.cancel();
        }
      });
    });
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
        child: Column(
          children: [
            Container(
              padding: CustomPadding.px2,
              child: labelText(),
            ),
            Container(
              padding: CustomPadding.p2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formInputOTP(),
                  CustomDividers.smallDivider(),
                  formResetOTP(),
                  CustomDividers.smallDivider(),
                  CustomDividers.smallDivider(),
                  buildButtonVerification(),
                  CustomDividers.smallDivider(),
                ],
              ),
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
        'Verifikasi OTP',
        style: TextStyles.h2(color: AppColors.secondary),
      ),
    );
  }

  Widget formInputOTP() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '2. Masukkan 6 digit angka OTP dari Email kamu',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        CustomDividers.smallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return Container(
              width: 55.0,
              height: 65.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.secondary,
                    width: 1.0), // Add your border color
              ),
              child: TextFormField(
                style: TextStyles.h3(color: AppColors.secondary),
                controller: _otpInputControllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < 5) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index + 1]);
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  }
                },
                decoration: const InputDecoration(
                  counterText: '',
                  focusedBorder: InputBorder.none, // Remove border when focused
                  enabledBorder:
                      InputBorder.none, // Remove border when not focused
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget formResetOTP() {
    String timerText =
        _timerActive ? '(${_secondsRemaining.toString().padLeft(2, '0')})' : '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tidak menerima kode OTP?',
          style: TextStyles.h4(color: AppColors.secondary),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                recognizer: _timerActive ? null : TapGestureRecognizer()
                  ?..onTap = () async {
                    final datasource = RequestOtpEmailDatasource();
                    final result =
                        await datasource.requestOtp(widget.inputEmail);
                    if (result.isRight()) {
                      print(widget.inputEmail);

                      setState(() {
                        _otpInputControllers[0].text = '';
                        _otpInputControllers[1].text = '';
                        _otpInputControllers[2].text = '';
                        _otpInputControllers[3].text = '';
                        _otpInputControllers[4].text = '';
                        _otpInputControllers[5].text = '';
                        _secondsRemaining = 300;
                        _timerActive = true;
                        _startTimer();
                      });
                    } else {
                      final error = result.fold((l) => l, (r) => '');
                      print('Error: $error');
                    }
                  },
                text: 'Kirim Lagi ',
                style: TextStyles.h4(
                  color: _timerActive ? AppColors.light : AppColors.primary,
                ),
              ),
              TextSpan(
                text: timerText,
                style: TextStyles.h4(
                  color: _timerActive ? AppColors.light : AppColors.primary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildButtonVerification() {
    return BlocListener<VerifyOtpBloc, VerifyOtpState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              showToast(message: 'Verifikasi berhasil, Silahkan login kembali');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
            error: (msg) {
              showToast(message: msg);
            });
      },
      child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                  text: 'Verifikasi',
                  onPressed: () {
                    if (validateOtpForm(_otpInputControllers)) {
                      String mergedOtpValue =
                          mergeOtpValue(_otpInputControllers);
                      context.read<VerifyOtpBloc>().add(
                          VerifyOtpEvent.verifyOtp(
                              widget.inputEmail, mergedOtpValue));
                    }
                  });
            },
            // loading: () {
            //   return ButtonFilled.primary(
            //     text: '',
            //     loading: true,
            //     onPressed: () {},
            //     textColor: AppColors.white,
            //   );
            // },
          );
        },
      ),
    );
  }
}
