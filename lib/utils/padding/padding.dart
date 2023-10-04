import 'package:flutter/widgets.dart';

class PaddingVerticalOnly {
  static const EdgeInsetsGeometry py1 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsetsGeometry py2 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsetsGeometry py3 = EdgeInsets.symmetric(vertical: 30);
}

class PaddingHorizontalOnly {
  static const EdgeInsetsGeometry px1 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsetsGeometry px2 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsetsGeometry px3 = EdgeInsets.symmetric(horizontal: 30);
}

class PaddingSymetricHorizontalVertical {
  static const EdgeInsetsGeometry p1 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsetsGeometry p2 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsetsGeometry p3 = EdgeInsets.symmetric(horizontal: 30);
}

class PaddingAll {
  static const EdgeInsets p1 = EdgeInsets.all(10);
  static const EdgeInsets p2 = EdgeInsets.all(20);
  static const EdgeInsets p3 = EdgeInsets.all(30);
}
