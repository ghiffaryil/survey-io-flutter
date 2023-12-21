import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_io/app.dart';
import 'package:survey_io/config/config.dart';
import 'package:survey_io/config/flavor_type.dart';

Future main() async {
  final prodAppConfig = AppConfig(
    appName: 'Survei.io',
    flavor: FlavorType.prod,
  );
  await dotenv.load(fileName: ".env");
  Widget app = initializeApp(prodAppConfig);
  runApp(app);
}
