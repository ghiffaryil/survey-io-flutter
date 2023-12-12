import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/variables.dart';
import 'package:survey_io/models/survey_design/create/survey_design_create_request_model.dart';
import 'package:survey_io/models/survey_design/create/survey_design_create_response_model.dart';

class SurveyDesignCreateDatasource {
  Future<Either<String, SurveyDesignCreateResponseModel>> Create(
      SurveyDesignCreateRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
      Uri.parse('${Variables.baseURL}/survey/design/create'),
      headers: headers,
      body: requestModel.toJson(),
    );

    try {
      print(response.body);
      if (response.statusCode == 200) {
        return Right(SurveyDesignCreateResponseModel.fromJson(response.body));
      } else {
        final errorResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final error = errorResponse['error'] as String? ?? 'Login Failed';
        return Left(error);
      }
    } catch (e) {
      return const Left('Login Failed');
    }
  }
}
