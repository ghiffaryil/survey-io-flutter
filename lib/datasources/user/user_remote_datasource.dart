import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';
import '../../models/user/profile_response_model.dart';

class ProfileRemoteDatasource {
  Future<Either<String, ProfileResponseModel>> getProfile() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': token
    };
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/user/get-profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Right(ProfileResponseModel.fromJson(response.body));
    } else {
      print(response.body);
      final errorResponse = json.decode(response.body) as Map<String, dynamic>;
      final error = errorResponse['error'] as String? ?? 'server error';
      return Left(error);
      // return const Left('server error');
    }
  }
}
