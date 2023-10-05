import 'package:flutter/material.dart';

class CustomDividers {
  static Widget verySmallDivider() {
    return const SizedBox(
      height: 10,
    );
  }

  static Widget smallDivider() {
    return const SizedBox(
      height: 20,
    );
  }

  static Widget regularDivider() {
    return const SizedBox(
      height: 40,
    );
  }

  static Widget mediumDivider() {
    return const SizedBox(
      height: 60,
    );
  }

  static Widget largeDivider() {
    return const SizedBox(
      height: 80,
    );
  }

  static Widget extraLargeDivider() {
    return const SizedBox(
      height: 100,
    );
  }
}
