import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/survey/survey_list_response_model.dart';
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class SurveyListDatasource {
  Future<Either<String, SurveyListResponseModel>> getSurveyList() async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': token
      };

      final body = {
        "limit": 99999,
        "offset": 0,
        "sort_by": [],
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/survey/get-list'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print(responseBody);
          return Right(SurveyListResponseModel.fromJson(responseBody));
        } else {
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        return const Left('Server Error');
      }
    }
  }
}
