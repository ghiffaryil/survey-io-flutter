import 'dart:async';

import 'package:flutter/material.dart';
import '../onboarding/presentation/onboarding.dart';

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
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 2);

    return Timer(durasiSplash, () {
      //pindah ke halaman home
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return const OnboardingPage();
      }));
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
          // height: 88,
        ),
      ),
    );
  }
}
