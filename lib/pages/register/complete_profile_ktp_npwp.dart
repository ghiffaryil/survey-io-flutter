import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';

// Import Component
import '../../../common/components/elevated_button.dart';
import '../../../common/components/input_field_date.dart';
import '../../../common/components/input_field_radio.dart';
import '../../../common/components/input_field_text.dart';
import '../../../common/constants/colors.dart';
import '../../../common/constants/styles.dart';
import '../../../common/components/divider.dart';
import '../../../common/components/label.dart';
import '../../../common/components/input_field_passcode.dart';
import '../../../common/constants/padding.dart';

class CompleteProfileKtpNPWP extends StatefulWidget {
  const CompleteProfileKtpNPWP({super.key});

  @override
  State<CompleteProfileKtpNPWP> createState() => _CompleteProfileKtpNPWPState();
}

class _CompleteProfileKtpNPWPState extends State<CompleteProfileKtpNPWP> {
  TextEditingController fullName = TextEditingController();
  TextEditingController placeOfBirth = TextEditingController();
  TextEditingController passcode = TextEditingController();
  TextEditingController ktpNumber = TextEditingController();
  TextEditingController npwpNumber = TextEditingController();
  TextEditingController referalCode = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode placeOfBirthFocus = FocusNode();
  FocusNode passcodeFocus = FocusNode();
  FocusNode ktpNumberFocus = FocusNode();
  FocusNode npwpNumberFocus = FocusNode();
  FocusNode referalCodeFocus = FocusNode();

  String gender = '';
  String selectedGender = '';
  bool _hidePasscode = true;

  void _showHidePasscodeTogle() {
    setState(() {
      _hidePasscode = !_hidePasscode;
    });
  }

  void unfocusAll() {
    fullNameFocus.unfocus();
    placeOfBirthFocus.unfocus();
    passcodeFocus.unfocus();
    ktpNumberFocus.unfocus();
    npwpNumberFocus.unfocus();
    referalCodeFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocusAll();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            padding: CustomPadding.p2,
            child: Column(
              children: [
                labelText(),
                formInputField(),
                CustomDividers.regularDivider(),
                CustomDividers.smallDivider(),
                submitButton(),
              ],
            ),
          ),
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
                      selectedGender = value;
                    });
                  },
                )),
            Container(
              width: 15,
            ),
            Expanded(
                flex: 5,
                child: RadioTextInput(
                  value: 'Perempuan',
                  selectedOption: selectedGender,
                  onChanged: (value) {
                    setState(() {
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
          focusNode: placeOfBirthFocus,
          controller: placeOfBirth,
          hintText: '01-01-1991',
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
          showPrefixIcon: false,
          showSuffixIcon: true,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'No. KTP',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: ktpNumberFocus,
          keyboardType: TextInputType.number,
          controller: referalCode,
          hintText: 'Masukkan No. KTP',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'No. NPWP',
          labelStyle: TextStyles.h4(color: AppColors.secondary),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: npwpNumberFocus,
          keyboardType: TextInputType.number,
          controller: referalCode,
          hintText: 'Masukkan No. NPWP (Jika Ada)',
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
          focusNode: referalCodeFocus,
          keyboardType: TextInputType.text,
          controller: referalCode,
          hintText: 'Masukkan Kode (Jika Ada)',
        ),
      ],
    );
  }

  Widget submitButton() {
    return ButtonFilled.primary(
        text: 'Submit',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SurveyDesign()));
        });
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
