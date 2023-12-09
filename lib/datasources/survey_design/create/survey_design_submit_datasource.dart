import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../login/auth_save_local_datasource.dart';
import '../../../../common/constants/variables.dart';

class SurveyDesignSubmitDatasource {
  Future<Either<String, String>> setSurveyDesignSubmit(
      int surveyDesignId) async {
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
        "id": surveyDesignId,
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/survey/design/submit'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      print(request.body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          print('Submit Success');
          return const Right('Success');
        } else {
          final Map<String, dynamic> errorResponse =
              json.decode(utf8.decode(await response.stream.toBytes()));
          final String errorMessage =
              errorResponse['error'] as String? ?? 'Failed!';

          print('Submit Failed: $errorMessage');
          return Left(errorMessage);
        }
      } catch (e) {
        print('Server Error');
        return const Left('Server Error');
      }
    }
  }
}
