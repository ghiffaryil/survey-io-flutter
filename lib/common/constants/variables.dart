import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {
  static String baseURL = "${dotenv.env['API_URL']}";
}
