import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_io/models/auth/auth_guest_response_model.dart';

class AuthLocalGuestDatasource {
  // SET DATA LOCAL
  Future<bool> saveAuthDataLocalGuest(AuthGuestResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('auth-guest', data.toJson());
    print('Save Guest Bearer Token');
    return result;
  }

  // REMOVE DATA LOCAL
  Future<bool> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('auth-guest');
    print('Remove Auth Data');
    return result;
  }

  // Future<bool> clearAuthData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final clear = await prefs.clear();
  //   print('Clear Auth Data');
  //   print(clear);
  //   return clear;
  // }

  // GET TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth-guest') ?? '';

    if (jsonString.isEmpty) {
      return '';
    } else {
      final authMap = json.decode(jsonString) as Map<String, dynamic>;
      // Check if the "data" key exists
      if (authMap.containsKey("data")) {
        final dataMap = authMap['data'] as Map<String, dynamic>;
        // Check if the "access_token" key exists within the "data" key
        if (dataMap.containsKey("access_token")) {
          // print('Disini');
          final accessToken = dataMap['access_token'];
          return accessToken.toString();
        } else {
          // print('Disana');
          return '';
        }
      } else {
        print('No "data" key found');
        return '';
      }
    }
  }
}
