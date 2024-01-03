import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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

Future<void> main() async {
  // Initialize packages and configurations
  await dotenv.load(fileName: ".dev.env");
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  HttpOverrides.global = MyHttpOverrides();

  // Initialize your AppConfig
  final devAppConfig = AppConfig(
    appName: 'Survei.io',
    flavor: FlavorType.dev,
  );

  // Initialize and run the app
  runApp(initializeApp(devAppConfig));
}
