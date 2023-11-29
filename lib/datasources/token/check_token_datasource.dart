import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class CheckTokenDatasource {
  Future<Either<String, String>> checkToken() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }

    final headers = {'authorization': token};
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/user/get-profile'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        print('Token OK');
        return const Right('Token OK');
      } else if (response.statusCode == 401) {
        if (response.body.contains("Token is expired")) {
          print('Token is Expired');
          return const Left('Token is Expired');
        } else {
          print('Unauthorized');
          return const Left('Unauthorized');
        }
      } else {
        print('Can\'t Load data');
        return const Left('Can\'t Load data');
      }
    } catch (e) {
      print('Server Error');
      return const Left('Server Error');
    }
  }
}
