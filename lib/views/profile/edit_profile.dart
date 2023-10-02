import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/header/leading.dart';
import 'package:survey_io/components/padding/padding.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/button/elevated_button_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';
import 'package:survey_io/components/input/input_label.dart';
import 'package:survey_io/components/input/input_text.dart';
import 'package:survey_io/views/login/login.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController NamaLengkap = TextEditingController();
  TextEditingController TanggalLahir = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController NomorTelepon = TextEditingController();

  FocusNode namaLengkapFocus = FocusNode();
  FocusNode tanggalLahirFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode noTeleponFocus = FocusNode();

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
    emailFocus.unfocus();
    noTeleponFocus.unfocus();
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
            leading: LeadingHeader(
              iconSize: 35.0,
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: AppColors.secondaryColor,
              leadingIcon: Icons.close, // Pass the icon data here
            )),
        backgroundColor: AppColors.bgDefault,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Text(
                  'Edit Profil',
                  style:
                      TextStyles.h2ExtraBold(color: AppColors.secondaryColor),
                ),
              ),
              Container(
                padding: PaddingAll.p3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormInputField(),
                    CustomDividers.largeDivider(),
                    SubmitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
          labelText: 'No. Telepon',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: noTeleponFocus,
          keyboardType: TextInputType.text,
          controller: NomorTelepon,
          hintText: '081234567890',
          suffixIconPNG: 'assets/images/icons/polling_check_info.png',
        ),
        CustomDividers.smallDivider(),
        LabelInput(
          labelText: 'Email',
          labelStyle: TextStyles.h4(color: AppColors.secondaryColor),
        ),
        CustomDividers.verySmallDivider(),
        TextInputField(
          focusNode: emailFocus,
          keyboardType: TextInputType.text,
          controller: Email,
          hintText: 'Masukkan Email Kamu',
        ),
      ],
    );
  }

  Widget SubmitButton() {
    return ElevatedButtonPrimary(
        text: 'Submit',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        });
  }
}
