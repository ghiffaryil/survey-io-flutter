import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';

import '../../models/survey/list/survey_list_response_model.dart';
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class SurveyPopularListDatasource {
  Future<Either<String, SurveyListResponseModel>> getSurveyPopularList() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();
    var userToken = '';

    if (token.isEmpty && guestToken.isEmpty) {
      return const Left('No access token available');
    } else {
      // IF Token Not Empty
      if (token.isNotEmpty) {
        userToken = token;
      } else if (guestToken.isNotEmpty) {
        // IF Guest Token Not Empty
        userToken = guestToken;
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': userToken
      };

      final body = {
        "limit": 3,
        "offset": 0,
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/survey/get-list'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body); // Encode the body as JSON

      try {
        final response = await http.Client().send(request);
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('Load Survey Popular : success');
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
