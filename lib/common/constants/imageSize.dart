import 'package:flutter/widgets.dart';

class AppWidth {
  static double imageSize(BuildContext context, double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  static const double full = 1;
  static const double extraLarge = 0.75;
  static const double large = 0.6;
  static const double medium = 0.5;
  static const double regular = 0.3;
  static const double small = 0.2;
  static const double verySmall = 0.1;
}

class AppHeight {
  static double imageSize(BuildContext context, double factor) {
    return MediaQuery.of(context).size.height * factor;
  }

  static const double full = 1;
  static const double extraLarge = 0.75;
  static const double large = 0.6;
  static const double medium = 0.5;
  static const double regular = 0.3;
  static const double small = 0.2;
  static const double verySmall = 0.1;
}
