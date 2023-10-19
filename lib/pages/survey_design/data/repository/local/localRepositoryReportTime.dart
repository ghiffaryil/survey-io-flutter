import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReportTimeChoiceRepository {
  Future<Map<String, dynamic>?> getChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? choiceValue = prefs.getString("ReportTimeChoice");
    if (choiceValue != null) {
      return jsonDecode(choiceValue);
    }
    return null;
  }

  Future<void> setChoice(String? choiceValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ReportTimeChoice', choiceValue!);
  }

  Future deleteChoice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('id');
      await prefs.remove('scope');
      await prefs.remove('price');
      await prefs.clear();
    } catch (e) {
      print('Error deleting shared preference keys: $e');
    }
  }
}
