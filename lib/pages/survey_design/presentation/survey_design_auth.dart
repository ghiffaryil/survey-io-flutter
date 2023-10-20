import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survey_io/common/components/divider.dart';
import 'package:survey_io/common/components/text_button.dart';
import 'package:survey_io/common/constants/colors.dart';
import 'package:survey_io/common/constants/images.dart';
import 'package:survey_io/common/constants/padding.dart';

import '../../../common/constants/imageSize.dart';
import '../../login/presentation/login.dart';
import '../../register/presentation/complete_profile_ktp_npwp.dart';
import '../../../common/constants/styles.dart';

class AuthSurveyDesign extends StatefulWidget {
  const AuthSurveyDesign({super.key});

  @override
  State<AuthSurveyDesign> createState() => _AuthSurveyDesignState();
}

class _AuthSurveyDesignState extends State<AuthSurveyDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: CustomPadding.p3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomDividers.extraLargeDivider(),
            Image.asset(
              Images.logoHorizontal,
              width: AppSizeWidth.imageSize(context, AppSizeWidth.large),
            ),
            Text(
              'Buat akun terlebih dahulu sebelum melanjutkan pembayaran dan pembuatan survei kamu',
              textAlign: TextAlign.center,
              style: TextStyles.extraLarge(color: AppColors.secondary),
            ),
            CustomDividers.smallDivider(),
            TextButtonFilled.primary(
              text: 'Daftar',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompleteProfileKtpNPWP()));
              },
            ),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Text(
                'Sudah Punya Akun?',
                style: TextStyles.large(color: AppColors.secondary),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: const Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ]),
            TextButtonOutlined.primary(
              text: 'Login',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
            CustomDividers.smallDivider(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Dengan menekan “Daftar” atau “Login”, kamu menyutujui ?',
                    style: TextStyles.large(color: AppColors.secondary),
                  ),
                  TextSpan(
                    text: ' Ketentuan Layanan',
                    style: TextStyles.large(color: AppColors.primary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Ketentuan Layanan');
                      },
                  ),
                  TextSpan(
                    text: ' Survei.io',
                    style: TextStyles.large(color: AppColors.secondary),
                  )
                ],
              ),
            ),
            CustomDividers.largeDivider(),
          ],
        ),
      ),
    );
  }
}
