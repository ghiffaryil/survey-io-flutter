import 'package:flutter/material.dart';

class TextStyles {
  // Gaya teks H1
  static TextStyle h1({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks H2
  static TextStyle h2({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks H3
  static TextStyle h3({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks H4
  static TextStyle h4({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks H5
  static TextStyle h5({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks H6
  static TextStyle h6({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
  }

  // Gaya teks regular
  static TextStyle regular({Color? color}) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    );
  }

  // Gaya teks small
  static TextStyle small({Color? color}) {
    return TextStyle(
      fontSize: 13.0,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // Gaya teks muted (seperti teks yang terlihat lebih pucat)
  static TextStyle muted({Color? color}) {
    return const TextStyle(
      fontSize: 16.0,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );
  }
}
