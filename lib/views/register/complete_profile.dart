import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:survey_io/components/button/button_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/divider/divider_component.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController PhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelText(),
              FormInputField(),
              CustomDividers.smallDivider(),
              ButtonDaftar(),
              CustomDividers.smallDivider(),
              TextSignInHere(),
            ],
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
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nama Lengkap',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: 'Nama Lengkap',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Jenis Kelamin',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: 'Jenis Kelamin',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tanggal Lahir',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: 'Tanggal Lahir',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Password',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
        CustomDividers.smallDivider(),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Kode Referal',
            style: TextStyles.h4(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: PhoneNumber,
          decoration: InputDecoration(
              hintText: 'Masukkan Kode Referal (Jika Ada)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.all(20.0)),
        ),
      ],
    );
  }

  Widget ButtonDaftar() {
    return ButtonPrimary(text: 'Daftar', onPressed: () {});
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
