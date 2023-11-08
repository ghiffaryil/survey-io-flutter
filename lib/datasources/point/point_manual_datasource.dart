import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PointManualDatasource {
  Future<Either<String, String>> setPointManual(
      int point, String phoneNumber) async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = {
        "phone_number": phoneNumber,
        "point": point,
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/user/point/manual'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          print('Point Manual : Success');
          return const Right('Point Sent!');
        } else {
          final Map<String, dynamic> errorResponse = json.decode(responseBody);
          final errorMessage = errorResponse['error'] as String;

          return Left(errorMessage);
        }
      } catch (e) {
        print('Point Manual : Failed');
        return Left(e.toString());
      }
    }
  }
}
