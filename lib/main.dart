import 'package:flutter/material.dart';
import 'package:survey_io/pages/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey Io',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      home: const SplashScreenPage(),
    );
  }
}
