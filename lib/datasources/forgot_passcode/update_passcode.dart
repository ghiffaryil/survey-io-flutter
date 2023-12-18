import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/variables.dart';

class UpdatePasscodeOtpDatasource {
  Future<Either<String, String>> update(
      String phoneNumber, String pin) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = {
      "phone_number": phoneNumber,
      "pin": pin,
    };

    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/user/forget/change'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Update Passcode Success');
        return const Right('Update Passcode Success');
      } else {
        final Map<String, dynamic> errorResponse = json.decode(responseBody);
        final errorMessage = errorResponse['error'] as String;

        return Left(errorMessage);
      }
    } catch (e) {
      print('Update Passcode Failed');
      return Left(e.toString());
    }
  }
}
