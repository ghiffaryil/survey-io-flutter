import 'package:flutter/material.dart';
import 'views/splashscreen/splashscreen.dart';

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
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFFFFFFF)),
      home: SplashScreenPage(),
    );
  }
}
