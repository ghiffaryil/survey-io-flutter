import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';
import 'package:survey_io/models/auth/auth_guest_response_model.dart';

import 'package:survey_io/common/constants/variables.dart';

class AuthRemoteGuestDatasource {
  Future<Either<String, AuthGuestResponseModel>> getToken() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/user/guest'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        print('Get Guest Token Success');
        // print(response.body);
        return Right(AuthGuestResponseModel.fromJson(response.body));
      } else {
        final errorResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final error =
            errorResponse['error'] as String? ?? 'Get Guest Token Failed';
        return Left(error);
      }
    } catch (e) {
      return const Left('Login Failed');
    }
  }

  Future<Either<String, String>> deleteToken() async {
    AuthLocalGuestDatasource().removeAuthData();
    // AuthLocalGuestDatasource().clearAuthData();
    return const Right('Logout Success');
  }
}
