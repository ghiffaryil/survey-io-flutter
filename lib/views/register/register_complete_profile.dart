import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/button/elevated_button_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/input/input_text.dart';
import 'package:survey_io/views/login/login.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelText(),
                FormInputField(),
                CustomDividers.smallDivider(),
                TextSignInHere(),
                CustomDividers.smallDivider(),
                CustomDividers.smallDivider(),
                SubmitButton(),
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: JenisKelamin == "Laki-laki"
                        ? AppColors.secondaryColor
                        : AppColors.secondaryColor.withOpacity(0.4),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Laki-laki',
                          style: TextStyles.extraLarge(
                              color: JenisKelamin == "Laki-laki"
                                  ? AppColors.secondaryColor
                                  : AppColors.secondaryColor.withOpacity(0.4)),
                        )),
                    Radio(
                      value: 'Laki-laki',
                      groupValue: JenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          JenisKelamin = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 15,
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: JenisKelamin == "Perempuan"
                        ? AppColors.secondaryColor
                        : AppColors.secondaryColor.withOpacity(0.4),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Perempuan',
                            style: TextStyles.extraLarge(
                                color: JenisKelamin == "Perempuan"
                                    ? AppColors.secondaryColor
                                    : AppColors.secondaryColor
                                        .withOpacity(0.4)),
                          )),
                    ),
                    Radio(
                      value: 'Perempuan',
                      groupValue: JenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          JenisKelamin = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
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

  Widget SubmitButton() {
    return ElevatedButtonPrimary(
        text: 'Submit',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
  }

  Widget TextSignInHere() {
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('OK');
                },
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
