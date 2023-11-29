import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingParticipateDatasource {
  Future<Either<String, String>> setPollingParticipate(
      int pollingListId) async {
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
        "polling_list_id": pollingListId,
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/polling/participate'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);
        if (response.statusCode == 200) {
          print('Vote Polling Done : Success');
          return const Right('Vote Success!');
        } else {
          return const Left('Vote failed!');
        }
      } catch (e) {
        print('Server Error');
        return const Left('Server Error');
      }
    }
  }
}
