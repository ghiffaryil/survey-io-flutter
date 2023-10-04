import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/custom_elevated_button.dart';
import 'package:survey_io/common/components/form_input_text.dart';

// Import Component
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/styles.dart';
import 'package:survey_io/pages/login/presentation/login.dart';
import 'package:survey_io/common/components/custom_divider.dart';
import 'package:survey_io/common/components/label_input.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController NamaLengkap = TextEditingController();
  TextEditingController TanggalLahir = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController KodeReferal = TextEditingController();

  FocusNode namaLengkapFocus = FocusNode();
  FocusNode tanggalLahirFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode kodeReferalFocus = FocusNode();

  String JenisKelamin = '';
  bool _hidePassword = true;

  void _showHidePasswordTogle() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void unfocusAll() {
    namaLengkapFocus.unfocus();
    tanggalLahirFocus.unfocus();
    passwordFocus.unfocus();
    kodeReferalFocus.unfocus();
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
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                LabelText(),
                FormInputField(),
                CustomDividers.smallDivider(),
                labelTermAndCondition(),
                CustomDividers.smallDivider(),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget LabelText() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sedikit Lagi....',
            style: TextStyles.h2(color: AppColors.secondaryColor),
          ),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '3. Lengkapi Profil Kamu',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        CustomDividers.smallDivider(),
      ],
    );
  }

  Widget FormInputField() {
    return Column(
      children: [
        LabelInput(
          labelText: 'Nama Lengkap',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: namaLengkapFocus,
          keyboardType: TextInputType.text,
          controller: NamaLengkap,
          hintText: 'Nama Lengkap',
          // prefixIcon: Icon(Icons.person), // Set prefix icon
          // suffixIcon: Icon(Icons.person), // Set suffix icon
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: RadioTextInput(
                    parameter: 'JenisKelamin', value: 'Laki-laki')),
            Container(
              width: 15,
            ),
            Expanded(
                flex: 5,
                child: RadioTextInput(
                    parameter: 'JenisKelamin', value: 'Perempuan')),
          ],
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Tanggal Lahir',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        DateInputField(
          focusNode: tanggalLahirFocus,
          controller: TanggalLahir,
          hintText: '01-01-1991',
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
          showPrefixIcon: false,
          showSuffixIcon: true,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Password',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        PasswordTextInput(
          focusNode: passwordFocus,
          controller: Password,
          hintText: 'Password',
          hidePassword: _hidePassword,
          onPasswordVisibilityToggle: _showHidePasswordTogle,
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Kode Referal',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: kodeReferalFocus,
          keyboardType: TextInputType.text,
          controller: KodeReferal,
          hintText: 'Masukkan Kode (Jika Ada)',
          // prefixIcon: Icon(Icons.person), // Set prefix icon
          // suffixIcon: Icon(Icons.person), // Set suffix icon
        ),
      ],
    );
  }

  Widget submitButton() {
    return ElevatedButtonPrimary(
        text: 'Submit',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
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
                style: TextStyles.regular(color: AppColors.secondaryColor)),
            TextSpan(
              text: ' Ketentuan Layanan',
              style: TextStyles.regular(color: AppColors.primaryColor),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
                text: ' Survei.io',
                style: TextStyles.regular(color: AppColors.secondaryColor)),
          ],
        ),
      ),
    );
  }
}
