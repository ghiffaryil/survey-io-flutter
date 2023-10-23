import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositoryDemographyReligion {
  Future<Map<String, dynamic>?> getOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? optionValue = prefs.getString("DemographyReligionValue");
    if (optionValue != null) {
      return jsonDecode(optionValue);
    }
    return null;
  }

  Future<void> setOption(String? optionValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DemographyReligionValue', optionValue!);
  }

  Future deleteOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.clear();
    } catch (e) {
      print('Error deleting shared preference keys: $e');
    }
  }
}
