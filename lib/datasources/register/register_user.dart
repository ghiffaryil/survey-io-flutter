import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/register/register_request_model.dart';
import 'package:survey_io/models/register/register_response_model.dart';
import 'package:survey_io/common/constants/variables.dart';

class RegisterUserDatasource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/user/register'),
      headers: headers,
      body: requestModel.toJson(),
    );

    try {
      print(response.body);
      if (response.statusCode == 200) {
        return Right(RegisterResponseModel.fromJson(response.body));
      } else {
        final errorResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final error = errorResponse['error'] as String? ?? 'Register Failed';
        return Left(error);
      }
    } catch (e) {
      return const Left('Register Failed');
    }
  }
}
