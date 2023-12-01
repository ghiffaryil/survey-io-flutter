import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/user/list_city_response_model.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/common/constants/variables.dart';

class GetListCityDatasource {
  Future<Either<String, ListCityResponseModel>> getCityList(
      int provinceId) async {
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

      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/user/city-list'),
      );

      final body = {
        "province_id": [provinceId],
      };

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('List City Success');
          return Right(ListCityResponseModel.fromJson(responseBody));
        } else {
          print('List City No Data');
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        print('Load Polling New : Failed');
        return const Left('Server Error');
      }
    }
  }
}
