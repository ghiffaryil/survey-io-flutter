import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/polling/polling_today_response_model.dart';
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingTodayDatasource {
  Future<Either<String, PollingTodayResponseModel>>
      getPollingTodayList() async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {'authorization': token};

      // final body = {
      //   "limit": 10,
      //   "offset": 0,
      //   "sort_by": ["lowestEnergy"],
      // };

      final response = await http.post(
        Uri.parse('${Variables.baseURL}/polling/today'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return Right(PollingTodayResponseModel.fromJson(response.body));
      } else {
        final errorResponse =
            json.decode(response.body) as Map<String, dynamic>;
        final error = errorResponse['error'] as String? ?? 'server error';
        return Left(error);
        // return const Left('server error');
      }
    }
  }
}
