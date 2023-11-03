import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/polling/polling_response_model.dart';
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingDatasource {
  Future<Either<String, PollingResponseModel>> getPollingList() async {
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
        Uri.parse('${Variables.baseURL}/polling/get-list'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('Load polling today : Success');
          return Right(PollingResponseModel.fromJson(responseBody));
        } else {
          print('Load polling today : No Data');
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        print('Load polling today : Failed');
        return const Left('Server Error');
      }
    }
  }
}
