import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:survey_io/components/button/button_component.dart';

// Import Component
import 'package:survey_io/components/color/color_component.dart';
import 'package:survey_io/components/text/text_component.dart';
import 'package:survey_io/components/spacing/spacing_component.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController PhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.secondaryColor,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar',
                style: TextStyles.h1(color: AppColors.secondaryColor),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '1. Masukkan Nomor Telepon',
                style: TextStyles.h3(color: AppColors.secondaryColor),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: PhoneNumber,
                decoration: InputDecoration(
                    hintText: '0812345678910',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Rounded corners
                      borderSide: const BorderSide(
                        color: AppColors.secondaryColor, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    contentPadding: EdgeInsets.all(20.0)),
              ),
            ),
            const SizedBox(
              height: smallSpacing,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.infoColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                    15.0), // Add borderRadius to the BoxDecoration
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                          child: SvgPicture.asset(
                              'assets/images/information/warning-info.svg'))),
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Nomor telepon tidak dapat diubah setelah akun dibuat. Pastikan nomor telepon kamu terkoneksi dengan WhatsApp',
                      style: TextStyles.small(color: AppColors.secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Container(
              child: ButtonPrimary(text: 'Daftar', onPressed: () {}),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Sudah Punya Akun ?',
                      style: TextStyles.h5(color: AppColors.secondaryColor)),
                  TextSpan(
                    text: ' Login di sini',
                    style: TextStyles.h5(color: AppColors.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('OK');
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
