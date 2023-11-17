import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:survey_io/datasources/login/auth_local_datasource.dart';
import 'package:survey_io/datasources/token/check_token_datasource.dart';
import 'package:survey_io/pages/survey_design/survey_design.dart';

import '../login/login.dart';
import '../profile/edit_profile_complete.dart';
import '../../common/components/divider.dart';
import '../../common/components/text_button.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';
import '../../common/constants/padding.dart';
import '../../../common/constants/imageSize.dart';
import '../../../common/constants/styles.dart';

class SurveyDesignAuth extends StatefulWidget {
  const SurveyDesignAuth({super.key});

  @override
  State<SurveyDesignAuth> createState() => _SurveyDesignAuthState();
}

class _SurveyDesignAuthState extends State<SurveyDesignAuth> {
  bool isLogged = false;
  bool isExpiredToken = false;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  void checkAuth() async {
    final isLogin = await AuthLocalDatasource().isLogin();
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
      });
    } else if (isLogin) {
      // CHECK TOKEN IS STILL AVAILABLE
      final result = await CheckTokenDatasource().checkToken();
      result.fold(
        (error) {
          setState(() {
            isLogged = true;
            isExpiredToken = true;
          });
        },
        (data) {
          setState(() {
            isLogged = true;
            isExpiredToken = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SurveyDesign()));
        },
      );
    } else {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
      });
    }

    // DO OPEN SPLASH SCREEN
  }

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
              width: AppWidth.imageSize(context, AppWidth.large),
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
                        builder: (context) => const EditProfileComplete()));
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
