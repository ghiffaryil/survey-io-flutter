import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/elevated_button.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';

import '../../../common/components/appbar_plain.dart';
import 'complete_profile.dart';

class VerificationOTP extends StatefulWidget {
  const VerificationOTP({super.key});

  @override
  State<VerificationOTP> createState() => _VerificationOTPState();
}

class _VerificationOTPState extends State<VerificationOTP> {
  String otpCode = '';

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _otpInputControllers =
      List.generate(4, (_) => TextEditingController());

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
    for (int i = 0; i < 4; i++) {
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
        height: 70.0,
        leadingIcon: Icons.arrow_back_ios,
        iconSize: 35.0,
        textColor: AppColors.secondary,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabelText(),
              CustomDividers.smallDivider(),
              buildFormInputOTP(),
              CustomDividers.smallDivider(),
              buildFormResetOTP(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
              ),
              buildButtonVerification(),
              CustomDividers.smallDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabelText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Verifikasi',
        style: TextStyles.h2(color: AppColors.secondary),
      ),
    );
  }

  Widget buildFormInputOTP() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '2. Masukkan 4 digit WhatsApp OTP',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        CustomDividers.smallDivider(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 60.0,
                height: 60.0,
                child: TextFormField(
                  style: TextStyles.h4(color: AppColors.secondary),
                  controller: _otpInputControllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        FocusScope.of(context)
                            .requestFocus(_focusNodes[index + 1]);
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildFormResetOTP() {
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
                  ?..onTap = () {
                    setState(() {
                      _secondsRemaining = 59;
                      _timerActive = true;
                      _startTimer();
                    });
                  },
                text: 'Kirim Lagi ',
                style: TextStyles.h4(
                  color: _timerActive ? AppColors.secondary : AppColors.primary,
                ),
              ),
              TextSpan(
                text: timerText,
                style: TextStyles.h4(
                  color: _timerActive ? AppColors.secondary : AppColors.primary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildButtonVerification() {
    return ButtonFilled.primary(
        text: 'Verifikasi',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CompleteProfile()));
        });
  }
}
