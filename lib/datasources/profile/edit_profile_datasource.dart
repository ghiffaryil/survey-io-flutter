import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/models/user/edit_profile_request_model.dart';
import '../../../common/constants/variables.dart';

class EditProfileDatasource {
  Future<Either<String, String>> update(
      EditProfileRequestModel requestModel) async {
    // GET TOKEN
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': token
      };
      final response = await http.post(
        Uri.parse('${Variables.baseURL}/user/edit-profile'),
        headers: headers,
        body: requestModel.toJson(),
      );

      // print(requestModel.toJson());

      try {
        // print(token);
        print(response.body);
        if (response.statusCode == 200) {
          return const Right('Update Success');
        } else {
          final errorResponse =
              json.decode(response.body) as Map<String, dynamic>;
          final error = errorResponse['error'] as String? ?? 'Update Failed';
          return Left(error);
        }
      } catch (e) {
        return Left('Update Failed $e');
      }
    }
  }
}
