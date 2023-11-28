import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/bloc/register/verify_otp/verify_otp_bloc.dart';
import 'package:survey_io/common/components/elevated_button.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/datasources/register/request_otp.dart';

import '../../../common/components/appbar_plain.dart';
import '../../../common/constants/padding.dart';
import 'register_complete.dart';

class VerificationOtpPage extends StatefulWidget {
  final String phoneNumber;

  const VerificationOtpPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerificationOtpPage> createState() => _VerificationOtpPageState();
}

class _VerificationOtpPageState extends State<VerificationOtpPage> {
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
              buildLabelText(),
              CustomDividers.smallDivider(),
              buildFormInputOTP(),
              CustomDividers.smallDivider(),
              buildFormResetOTP(),
              CustomDividers.smallDivider(),
              CustomDividers.smallDivider(),
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
                  ?..onTap = () async {
                    // If Want to Send Point Manual

                    final datasource = RequestOtpDatasource();
                    final result =
                        await datasource.requestOtp(widget.phoneNumber);
                    if (result.isRight()) {
                      setState(() {
                        _otpInputControllers[0].text = '';
                        _otpInputControllers[1].text = '';
                        _otpInputControllers[2].text = '';
                        _otpInputControllers[3].text = '';
                        _secondsRemaining = 59;
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
              String otpCode = data.otpCode;
              int otpId = data.id;

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return CompleteProfile(
                  sendPhoneNumber: widget.phoneNumber,
                  otpCode: otpCode,
                  otpId: otpId,
                );
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
      child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
        builder: (context, state) {
          String mergedOtpValue = _otpInputControllers.sublist(0, 4).fold('',
              (String previousValue, TextEditingController controller) {
            return previousValue + controller.text;
          });

          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Verifikasi',
                onPressed: () {
                  print(mergedOtpValue);
                  context.read<VerifyOtpBloc>().add(VerifyOtpEvent.verifyOtp(
                      widget.phoneNumber, mergedOtpValue));
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
}
