import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RespondentChoiceRepository {
  Future<Map<String, dynamic>?> getChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? choiceValue = prefs.getString("RespondentChoice");
    if (choiceValue != null) {
      return jsonDecode(choiceValue);
    }
    return null;
  }

  Future<void> setChoice(String? choiceValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('RespondentChoice', choiceValue!);
  }

  Future deleteChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('id');
      await prefs.remove('scope');
      await prefs.clear();
    } catch (e) {
      print('Error deleting shared preference keys: $e');
    }
  }
}
