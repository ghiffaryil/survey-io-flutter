import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositorySurveyDesignPrice {
  Future<Map<String, dynamic>?> getOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? optionValue = prefs.getString("SurveyDesignPrice");
    if (optionValue != null) {
      return jsonDecode(optionValue);
    }
    return null;
  }

  Future<void> setOption(String? optionValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('SurveyDesignPrice', optionValue!);
  }

  Future deleteOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('SurveyDesignPrice');
    } catch (e) {
      print('Error deleting shared preference keys: $e');
    }
  }
}
