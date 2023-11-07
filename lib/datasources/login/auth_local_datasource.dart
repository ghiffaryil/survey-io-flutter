import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/auth/auth_response_model.dart';

class AuthLocalDatasource {
  // SET DATA LOCAL
  Future<bool> saveAuthData(AuthResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('auth', data.toJson());
    return result;
  }

  // REMOVE DATA LOCAL
  Future<bool> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('auth');
    print(result);
    return result;
  }

  Future<bool> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final clear = await prefs.clear();
    print(clear);
    return clear;
  }

  // GET TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    if (jsonString.isEmpty) {
      return '';
    } else {
      // final authModel = AuthResponseModel.fromJson(jsonString);
      final authMap = json.decode(jsonString) as Map<String, dynamic>;

      if (authMap.containsKey("access_token")) {
        final accessToken = authMap['access_token'];
        return accessToken.toString(); // Make sure to convert it to a string.
      } else {
        return ''; // Handle the case where "access_token" is missing.
      }
      // return authModel.accessToken;
    }
  }

  // IS LOGIN?
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }

  // GET USER
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    final authModel = AuthResponseModel.fromJson(jsonString);
    // Get JSON {user}
    return authModel.user;
  }
}
