import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/reedem/reedem_history_response_model.dart';

import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class ReedemHistoryDatasource {
  Future<Either<String, ReedemHistoryResponseModel>>
      getListReedemHistory() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }

    final headers = {'authorization': token};
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/redeem/history'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        print('Get List Reedem History : success');
        print(response.body);
        return Right(ReedemHistoryResponseModel.fromJson(response.body));
      } else {
        print('Get List Reedem History : no data');
        return const Left('Can\'t Load data ');
      }
    } catch (e) {
      print('Get List Reedem History : $e');
      return const Left('No Data');
    }
  }
}
