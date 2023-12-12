import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/variables.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_request_model.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_response_model.dart';

class SurveyDesignIsCalculateDatasource {
  Future<Either<String, SurveyDesignIsCalculateResponseModel>> isCalculate(
      SurveyDesignIsCalculateRequestModel requestModel) async {
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
        return Right(
            SurveyDesignIsCalculateResponseModel.fromJson(response.body));
      } else {
        final errorResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final error =
            errorResponse['error'] as String? ?? 'Is Calculate Failed';
        return Left(error);
      }
    } catch (e) {
      return const Left('Is Calculate Failed');
    }
  }
}
