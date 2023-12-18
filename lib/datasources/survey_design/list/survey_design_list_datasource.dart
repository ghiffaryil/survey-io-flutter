import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/survey_design/list/survey_design_list_response_model.dart';

import '../../login/auth_save_local_datasource.dart';
import '../../../../common/constants/variables.dart';

class SurveyDesignListDatasource {
  Future<Either<String, SurveyDesignListResponseModel>>
      getSurveyDesignList() async {
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
        'GET',
        Uri.parse('${Variables.baseURL}/survey/design/get-list'),
      );

      request.headers.addAll(headers);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('List Survey Design Success');
          print(responseBody);
          return Right(SurveyDesignListResponseModel.fromJson(responseBody));
        } else {
          print('List Survey Design No Data');
          return const Left('No data ');
        }
      } catch (e) {
        print('Load Survey Design : Failed');
        return const Left('Server Error');
      }
    }
  }
}
