import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/polling/polling_done_response_model.dart';
import '../../../common/constants/variables.dart';
import '../login/auth_save_local_datasource.dart';

class PollingDoneDatasource {
  Future<Either<String, PollingDoneResponseModel>> getPollingDoneList() async {
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
        "offset": 0,
        "sort_by": ["newest"],
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/polling/done'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('Load Polling Done : Success');
          return Right(PollingDoneResponseModel.fromJson(responseBody));
        } else {
          print('Load Polling Done : No Data');
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        print('Load Polling Done : Failed');
        return const Left('Server Error');
      }
    }
  }
}
