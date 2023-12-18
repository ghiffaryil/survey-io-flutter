import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/variables.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/models/survey_design/is_create/survey_design_is_create_request_model.dart';

class SurveyDesignIsCreateDatasource {
  Future<Either<String, String>> isCreate(
      SurveyDesignIsCreateRequestModel requestModel) async {
    final token = await AuthLocalDatasource().getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': token
    };
    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/survey/design/create'),
    );

    request.headers.addAll(headers);
    request.body = requestModel.toJson();
    final response = await http.Client().send(request);

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> responseData = json.decode(responseBody);

      if (responseData.containsKey('data')) {
        final createQuestionUrl =
            responseData['data']['create_question_url'] as String?;
        if (createQuestionUrl != null) {
          print('Create Success');
          print('create_question_url: $createQuestionUrl');
          return Right(createQuestionUrl);
        }
      }
      return const Left('Failed to extract create_question_url');
    } else {
      try {
        final Map<String, dynamic> errorResponse =
            json.decode(utf8.decode(await response.stream.toBytes()));
        final String errorMessage =
            errorResponse['error'] as String? ?? 'Failed!';

        print('Create Failed: $errorMessage');
        return Left(errorMessage);
      } catch (e) {
        // If decoding as a Map fails, treat the entire response as a String
        final String errorBody = utf8.decode(await response.stream.toBytes());
        print('Create Failed: $errorBody');
        return Left(errorBody);
      }
    }
  }
}
