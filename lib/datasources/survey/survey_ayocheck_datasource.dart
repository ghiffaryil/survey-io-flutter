import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/datasources/guest/auth_local_guest_datasource.dart';

import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';
import '../../models/survey/survey_ayocheck_response_model.dart';

class SurveyAyoCheckDatasource {
  Future<Either<String, SurveyAyoCheckResponseModel>>
      getSurveyAyoCheck() async {
    final token = await AuthLocalDatasource().getToken();
    final guestToken = await AuthLocalGuestDatasource().getToken();
    var userToken = '';

    print('Guest Token = $guestToken');

    if (token.isEmpty && guestToken.isEmpty) {
      return const Left('No access token available');
    } else {
      // IF Token Not Empty
      if (token.isNotEmpty) {
        userToken = token;
      } else if (guestToken.isNotEmpty) {
        // IF Guest Token Not Empty
        userToken = guestToken;
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': userToken
      };

      try {
        final response = await http.get(
          Uri.parse('${Variables.baseURL}/survey/ayocheck'),
          headers: headers,
        );
        if (response.statusCode == 200) {
          print('Load Survey Ayo Check : success');
          return Right(SurveyAyoCheckResponseModel.fromJson(response.body));
        } else {
          final errorResponse =
              json.decode(response.body) as Map<String, dynamic>;
          final error = errorResponse['error'] as String? ?? 'server error';
          return Left(error);
        }
      } catch (e) {
        return const Left('Server Error');
      }
    }
  }
}
