import 'package:flutter/material.dart';

class CustomDividers {
  // Divider with small height (10)
  static Widget verySmallDivider() {
    return const SizedBox(
      height: 10,
    );
  }

  // Divider with small height (20)
  static Widget smallDivider() {
    return const SizedBox(
      height: 20,
    );
  }

  // Divider with large height (60)
  static Widget regularDivider() {
    return const SizedBox(
      height: 40,
    );
  }

  // Divider with large height (60)
  static Widget mediumDivider() {
    return const SizedBox(
      height: 60,
    );
  }

  // Divider with extra-large height (80)
  static Widget largeDivider() {
    return const SizedBox(
      height: 80,
    );
  }

  // Divider with extra-large height (100)
  static Widget extraLargeDivider() {
    return const SizedBox(
      height: 100,
    );
  }
}
