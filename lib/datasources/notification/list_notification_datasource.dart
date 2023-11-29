import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_save_local_datasource.dart';
import '../../models/notification/notification_response_model.dart';
import '../../../common/constants/variables.dart';

class NotificationDatasource {
  Future<Either<String, NotificationResponseModel>>
      getListNotification() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }
    final headers = {'authorization': token};
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/user/notif'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        return Right(NotificationResponseModel.fromJson(response.body));
      } else {
        return const Left('Can\'t Load data ');
      }
    } catch (e) {
      return const Left('Server Error');
    }
  }
}
