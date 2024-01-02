import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:survey_io/common/components/appbar_plain.dart';
import 'package:survey_io/common/components/elevated_button.dart';
import 'package:survey_io/common/components/input_field_date.dart';
import 'package:survey_io/common/components/input_field_radio.dart';
import 'package:survey_io/common/components/input_field_text.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/pages/login/login.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/label.dart';
import 'package:survey_io/bloc/register/register/register_bloc.dart';
import 'package:survey_io/models/register/register_request_model.dart';
import 'package:survey_io/common/components/input_field_passcode.dart';

class CompleteProfile extends StatefulWidget {
  final String sendPhoneNumber;
  final String otpCode;
  final int otpId;

  const CompleteProfile(
      {super.key,
      required this.sendPhoneNumber,
      required this.otpCode,
      required this.otpId});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController fullName = TextEditingController();
  TextEditingController dob = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController province = TextEditingController();
  TextEditingController city = TextEditingController();

  TextEditingController passcode = TextEditingController();
  TextEditingController referalCode = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode passcodeFocus = FocusNode();
  FocusNode referalCodeFocus = FocusNode();

  String gender = '';
  String selectedGender = '';
  bool _hidePasscode = true;

  @override
  void initState() {
    super.initState();
    unfocusAll();
    phoneNumber.text = widget.sendPhoneNumber;
  }

  void _showHidePasscodeTogle() {
    setState(() {
      _hidePasscode = !_hidePasscode;
    });
  }

  void unfocusAll() {
    fullNameFocus.unfocus();
    dobFocus.unfocus();
    passcodeFocus.unfocus();
    referalCodeFocus.unfocus();
  }

  bool _validateForm() {
    if (fullName.text.isEmpty) {
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
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (dob.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Date of Birth',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } else if (phoneNumber.text.isEmpty) {
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
    return GestureDetector(
      onTap: () {
        unfocusAll();
      },
      child: Scaffold(
        appBar: PlainAppBar(
            height: 20,
            onPressed: () {},
            leadingIcon: null,
            iconColor: AppColors.white),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: const EdgeInsets.only(bottom: 5),
              child: labelText(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      formInputField(),
                      CustomDividers.regularDivider(),
                      labelTermAndCondition(),
                      CustomDividers.smallDivider(),
                      submitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget labelText() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sedikit Lagi....',
            style: TextStyles.h2(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '3. Lengkapi Profil Kamu',
            style: TextStyles.h4(color: AppColors.secondary),
          ),
        ),
        CustomDividers.smallDivider(),
      ],
    );
  }

  Widget formInputField() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Nama Lengkap',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: fullNameFocus,
          keyboardType: TextInputType.text,
          controller: fullName,
          hintText: 'Nama Lengkap',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Nomor Handphone',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: phoneNumberFocus,
          keyboardType: TextInputType.text,
          controller: phoneNumber,
          hintText: '08123456789',
          editable: false,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Email',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: emailFocus,
          keyboardType: TextInputType.emailAddress,
          controller: email,
          hintText: 'Email',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Laki-laki',
                  selectedOption: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      gender = 'male';
                      selectedGender = value;
                    });
                  },
                )),
            Container(
              width: 10,
            ),
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Perempuan',
                  selectedOption: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      gender = 'female';
                      selectedGender = value;
                    });
                  },
                )),
          ],
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Tanggal Lahir',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        DateInputField(
          focusNode: dobFocus,
          controller: dob,
          hintText: '01-01-1991',
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
          showPrefixIcon: false,
          showSuffixIcon: true,
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
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Kode Referal',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          keyboardType: TextInputType.text,
          controller: referalCode,
          hintText: 'Masukkan Kode (Jika Ada)',
          // prefixIcon: Icon(Icons.person), // Set prefix icon
          // suffixIcon: Icon(Icons.person), // Set suffix icon
        ),
      ],
    );
  }

  Widget submitButton() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              // Lakukan Login
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
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

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            });
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                text: 'Submit',
                onPressed: () {
                  DateTime parsedDate =
                      DateFormat('dd-MM-yyyy').parse(dob.text);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(parsedDate);

                  if (_validateForm()) {
                    final requestModel = RegisterRequestModel(
                      name: fullName.text,
                      phoneNumber: phoneNumber.text,
                      email: email.text,
                      gender: gender,
                      dob: formattedDate,
                      province: 'DKI Jakarta',
                      city: 'Jakarta Selatan',
                      pin: passcode.text,
                      firebaseToken: '32jr982jd9137asd2',
                      platform: 'android',
                      deviceId: 'xxx01',
                      otpId: widget.otpId,
                      referalCode: referalCode.text,
                    );
                    context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.registerUser(requestModel));
                  }
                },
              );
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

  Widget labelTermAndCondition() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Dengan menekan “Submit”, kamu menyutujui',
                style: TextStyles.regular(color: AppColors.secondary)),
            TextSpan(
              text: ' Ketentuan Layanan',
              style: TextStyles.regular(color: AppColors.primary),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
                text: ' Survei.io',
                style: TextStyles.regular(color: AppColors.secondary)),
          ],
        ),
      ),
    );
  }
}
