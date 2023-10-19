import 'package:flutter/material.dart';

class TextStyles {
  // Gaya teks H1
  static TextStyle h1({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H2
  static TextStyle h2({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H3
  static TextStyle h3({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H4
  static TextStyle h4({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H5
  static TextStyle h5({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H6
  static TextStyle h6({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-Bold',
      color: color,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // EXTRA BOLD
  static TextStyle h1ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H2
  static TextStyle h2ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 35.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H3
  static TextStyle h3ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H4
  static TextStyle h4ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H5
  static TextStyle h5ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks H6
  static TextStyle h6ExtraBold({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      color: color,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
    );
  }

  // Gaya teks extraLarge
  static TextStyle extraLarge({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: 20.0,
      fontFamily: 'Nunito',
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  // Gaya teks large
  static TextStyle large({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: 18.0,
      fontFamily: 'Nunito',
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  // Gaya teks regular
  static TextStyle medium({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 17.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  // Gaya teks regular
  static TextStyle regular({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: 'Nunito',
      color: color,
      fontSize: 16.0,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  // Gaya teks small
  static TextStyle small({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: 13.0,
      fontFamily: 'Nunito',
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  // Gaya teks small
  static TextStyle verySmall({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: 9.0,
      fontFamily: 'Nunito',
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }

  // Gaya teks muted (seperti teks yang terlihat lebih pucat)
  static TextStyle muted({
    Color? color,
    FontWeight? fontWeight,
  }) {
    return const TextStyle(
      fontSize: 16.0,
      fontFamily: 'Nunito',
      color: Colors.grey,
    );
  }
}
