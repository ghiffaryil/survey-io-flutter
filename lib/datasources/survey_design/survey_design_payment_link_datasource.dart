import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/survey_design/survey_payment_link_response_model.dart';
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class SurveyDesignPaymentLinkDatasource {
  Future<Either<String, SurveyPaymentLinkResponseModel>>
      getSurveyDesignPaymentLink(int surveyDesignId) async {
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
      try {
        final response = await http.get(
          Uri.parse('${Variables.baseURL}/survey/payment?id=$surveyDesignId'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          print('PaymentLink Success');
          return Right(SurveyPaymentLinkResponseModel.fromJson(response.body));
        } else {
          print('Load Survey Design : No Data');
          var errorMessage = 'PaymentLink Failed: ';
          return Left(errorMessage);
        }
      } catch (e) {
        print('Server Error');
        return const Left('Server Error');
      }
    }
  }
}
