import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../common/constants/variables.dart';

class RequestOtpDatasource {
  Future<Either<String, String>> requestOtp(String email) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = {
      "email": email,
    };

    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/user/send-email-otp'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      print('Status : ${response.statusCode}');
      print('Body : $responseBody');

      if (response.statusCode == 200) {
        print('Request OTP : Success');
        return const Right('Request OTP Success');
      } else {
        final Map<String, dynamic> errorResponse = json.decode(responseBody);
        final errorMessage = errorResponse['error'] as String;

        return Left(errorMessage);
      }
    } catch (e) {
      print('Request OTP : Failed');
      return Left(e.toString());
    }
  }
}
