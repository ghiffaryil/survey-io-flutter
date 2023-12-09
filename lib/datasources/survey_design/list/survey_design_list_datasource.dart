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
    }

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'authorization': token
    };

    try {
      final response = await http.get(
        Uri.parse('${Variables.baseURL}/survey/design/get-list'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('Load Survey Design : success');
        return Right(SurveyDesignListResponseModel.fromJson(response.body));
      } else {
        print('Load Survey Design : No Data');
        return const Left('Can\'t Load data ');
      }
    } catch (e) {
      print('Load Survey Design : $e');
      return const Left('Server Error');
    }
  }
}
