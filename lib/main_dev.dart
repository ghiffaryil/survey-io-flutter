import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_io/app.dart';
import 'package:survey_io/config/config.dart';
import 'package:survey_io/config/flavor_type.dart';

class MyHttpOverrides extends HttpOverrides {
  // HANDLE NOT SECURE CERTIFICATE
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  final devAppConfig = AppConfig(
    appName: 'Survei.io Dev',
    flavor: FlavorType.dev,
  );
  await dotenv.load(fileName: ".dev.env");
  HttpOverrides.global = MyHttpOverrides();
  Widget app = initializeApp(devAppConfig);
  runApp(app);
}
