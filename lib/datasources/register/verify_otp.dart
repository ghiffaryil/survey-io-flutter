import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/register/verification_otp_response_model.dart';
import '../../../common/constants/variables.dart';

class VerifyOtpDatasource {
  Future<Either<String, VerificationOtpResponseModel>> verifyOtp(
      String phoneNumber, String otpCode) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = {
      "phone_number": phoneNumber,
      "otp_code": otpCode,
    };

    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/user/verify-otp'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      print('Status ${response.statusCode}');
      print('Body $responseBody');

      if (response.statusCode == 200) {
        print('Verify OTP: Success');
        return Right(VerificationOtpResponseModel.fromJson(responseBody));
      } else {
        final Map<String, dynamic> errorResponse = json.decode(responseBody);
        final errorMessage = errorResponse['error'] as String;

        return Left(errorMessage);
      }
    } catch (e) {
      print('Verify OTP: Failed');
      return Left(e.toString());
    }
  }
}
