import 'dart:async';

import 'package:flutter/material.dart';
import '../home/home.dart';
import '../onboarding/onboarding.dart';
import '../../datasources/login/auth_local_datasource.dart';
import '../../datasources/token/check_token_datasource.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  bool isLogged = false;
  bool isExpiredToken = false;

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    final isLogin = await AuthLocalDatasource().isLogin();
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
      });
    } else if (isLogin) {
      // CHECK TOKEN IS STILL AVAILABLE OR
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
        },
      );
    } else {
      setState(() {
        isLogged = false;
        isExpiredToken = true;
      });
    }

    // DO OPEN SPLASH SCREEN
    openSplashScreen();
  }

  openSplashScreen() async {
    var splashDuration = const Duration(seconds: 2);

    return Timer(splashDuration, () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FutureBuilder<bool>(
                future: AuthLocalDatasource().isLogin(),
                builder: (context, snapshot) {
                  if (isExpiredToken) {
                    return const OnboardingPage();
                  } else if (snapshot.hasData && snapshot.data!) {
                    return const HomePage();
                  } else {
                    return const OnboardingPage();
                  }
                },
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/logo/logo_survey_io_square.png",
          width: MediaQuery.of(context).size.width * 0.65,
        ),
      ),
    );
  }
}
