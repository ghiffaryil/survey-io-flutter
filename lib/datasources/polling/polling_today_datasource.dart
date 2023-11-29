import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';

import '../../models/polling/polling_today_response_model.dart';
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingTodayDatasource {
  Future<Either<String, PollingTodayResponseModel>>
      getPollingTodayList() async {
    // Get token from Shared Preferences Local
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
        "offset": 0,
        "sort_by": ["newest"],
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/polling/today'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('Load Polling Today : Success');
          return Right(PollingTodayResponseModel.fromJson(responseBody));
        } else {
          print('Load Polling Today : No Data');
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        print('Load Polling Today : Failed');
        return Left('Can\'t loaded data ');
      }
    }
  }
}
