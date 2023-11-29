import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/reedem/topup_prepaid_response_model.dart';
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class TopUpPrepaidDatasource {
  Future<Either<String, TopUpPrepaidResponseModel>> setTopUpPrepaid(
      String productCode) async {
    print(productCode);
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
        "product_code": productCode,
      };

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/redeem/topup/prepaid'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          print('Top Up Process : Success');
          return Right(TopUpPrepaidResponseModel.fromJson(responseBody));
        } else if (response.statusCode == 400) {
          print('Top Up Process : Success');
          return const Left('Point anda tidak mencukupi');
        } else {
          final Map<String, dynamic> errorResponse = json.decode(responseBody);
          final errorMessage = errorResponse['error'] as String;
          return Left(errorMessage);
        }
      } catch (e) {
        print('Top Up Process : Failed');
        return Left(e.toString());
      }
    }
  }
}
