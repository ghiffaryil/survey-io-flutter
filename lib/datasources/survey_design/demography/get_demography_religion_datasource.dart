import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/common/constants/variables.dart';
import 'package:survey_io/datasources/login/auth_save_local_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_religion_response_model.dart';

class GetDemographyReligionDatasource {
  Future<Either<String, DemographyReligionResponseModel>> getData() async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final request = http.Request(
        'GET',
        Uri.parse('${Variables.baseURL}/survey/demography/religion'),
      );

      request.headers.addAll(headers);

      try {
        final response = await http.Client().send(request);

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          print('List Data Success');
          return Right(DemographyReligionResponseModel.fromJson(responseBody));
        } else {
          print('No Data');
          return const Left('Can\'t Load data ');
        }
      } catch (e) {
        print('Load Data Failed');
        return const Left('Server Error');
      }
    }
  }
}
