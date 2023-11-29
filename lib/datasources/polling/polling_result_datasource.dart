import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../models/polling/polling_result_response_model.dart';
import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingResultDatasource {
  Future<Either<String, PollingResultResponseModel>> getPollingResultList(
      int pollingId) async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    print('pollingId => $pollingId');

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
        Uri.parse('${Variables.baseURL}/polling/result?polling_id=$pollingId'),
      );

      request.headers.addAll(headers);

      try {
        final response = await http.Client().send(request);
        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          // return Right('Load Polling Done : Success');
          print(responseBody);
          return Right(PollingResultResponseModel.fromJson(responseBody));
        } else {
          return const Left('No Data failed!');
          // return const Left('server error');
        }
      } catch (e) {
        print('Load Polling Done : Failed');
        return const Left('Server Error');
      }
    }
  }
}
