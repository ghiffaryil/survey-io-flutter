import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';
import '../../models/survey/survey_ayocheck_response_model.dart';

class SurveyAyoCheckDatasource {
  Future<Either<String, SurveyAyoCheckResponseModel>>
      getSurveyAyoCheck() async {
    
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': token
    };
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/survey/ayocheck'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(SurveyAyoCheckResponseModel.fromJson(response.body));
    } else {
      final errorResponse = json.decode(response.body) as Map<String, dynamic>;
      final error = errorResponse['error'] as String? ?? 'server error';
      return Left(error);
      // return const Left('server error');
    }
  }
}
