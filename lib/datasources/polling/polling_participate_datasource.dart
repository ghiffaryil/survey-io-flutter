import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class PollingParticipateDatasource {
  Future<Either<String, String>> setPollingParticipate(
      int pollingId) async {
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
        Uri.parse('${Variables.baseURL}/polling/participate'),
      );

      request.headers.addAll(headers);
      
      try {
      final response = await http.Client().send(request);
      if (response.statusCode == 200) {
        
        // final responseBody = await response.stream.bytesToString();
          print('Load Polling Done : Success');
          return Right('Vote Success');
      } else {
        return const Left('Vote failed!');
        // return const Left('server error');
      }
       } catch (e) {
        print('Load Polling Done : Failed');
        return const Left('Server Error');
      }
    }
  }
}