import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_io/app.dart';
import 'package:survey_io/config/config.dart';
import 'package:survey_io/config/flavor_type.dart';

Future main() async {
  final devAppConfig = AppConfig(
    appName: 'Survei.io Dev',
    flavor: FlavorType.dev,
  );
  await dotenv.load(fileName: ".dev.env");
  Widget app = await initializeApp(devAppConfig);
  runApp(app);
}
