import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ScreenerChoiceRepository {
  Future<Map<String, dynamic>?> getChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? choiceValue = prefs.getString("ScreenerChoice");
    if (choiceValue != null) {
      return jsonDecode(choiceValue);
    }
    return null;
  }

  Future<void> setChoice(String? choiceValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ScreenerChoice', choiceValue!);
  }

  Future deleteChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('value');
      await prefs.clear();
    } catch (e) {
      print('Error deleting shared preference keys: $e');
    }
  }
}
