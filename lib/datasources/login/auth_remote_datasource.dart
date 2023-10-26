import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/variables.dart';
import '../../../models/auth/auth_request_model.dart';
import '../../../models/auth/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/user/login'),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      print(response.body);
      final errorResponse = json.decode(response.body) as Map<String, dynamic>;
      final error = errorResponse['error'] as String? ?? 'server error';
      return Left(error);
      // return const Left('server error');
    }
  }

  Future<Either<String, String>> logout() async {
    return const Right('Logout Success');
  }
}
