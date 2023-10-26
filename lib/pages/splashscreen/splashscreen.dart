import 'dart:async';

import 'package:flutter/material.dart';
import 'package:survey_io/datasources/login/auth_local_datasource.dart';
import 'package:survey_io/pages/home/home.dart';
import '../onboarding/onboarding.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    var splashDuration = const Duration(seconds: 2);

    return Timer(splashDuration, () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => FutureBuilder<bool>(
                future: AuthLocalDatasource().isLogin(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
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
