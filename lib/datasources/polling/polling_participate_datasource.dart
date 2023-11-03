import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingParticipateDatasource {
  Future<Either<String, String>> setPollingParticipate(
      int selectedItemId) async {
    // Get token from Shared Preferences Local
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {'authorization': token};
      final body = {
        "polling_list_id": selectedItemId,
      };

      final response = await http.post(
        Uri.parse('${Variables.baseURL}/polling/participate'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        return const Right('Success!');
      } else {
        return const Left('Vote failed!');
        // return const Left('server error');
      }
    }
  }
}
