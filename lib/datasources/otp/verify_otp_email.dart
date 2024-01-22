import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../common/constants/variables.dart';

class VerifyOtpEmailDatasource {
  Future<Either<String, String>> verifyOtp(String email, String otpCode) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = {
      "email": email,
      "otp": otpCode,
    };

    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/user/verify-email-otp'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    final response = await http.Client().send(request);
    final responseBody = await response.stream.bytesToString();

    print('Status ${response.statusCode}');
    print('Body $responseBody');

    try {
      if (response.statusCode == 200) {
        print('Verify OTP: Success');
        // return Right(VerificationOtpResponseModel.fromJson(responseBody));
        return const Right('Success');
      } else {
        final Map<String, dynamic> errorResponse = json.decode(responseBody);
        final errorMessage = errorResponse['error'] as String;
        return Left(errorMessage);
      }
    } catch (e) {
      return const Left('Failed');
    }
  }
}
