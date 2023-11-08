import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../login/auth_local_datasource.dart';
import '../../../common/constants/variables.dart';

class ReadNotifDatasource {
  Future<Either<String, String>> setReadNotif(int notificationId) async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    } else {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': token
      };
      final body = {"id": notificationId};
      final request = http.Request(
        'POST',
        Uri.parse('${Variables.baseURL}/user/notif/read'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);
        print(response.statusCode.toString());
        if (response.statusCode == 200) {
          print('Read Notification : Success');
          return const Right('Read Success!');
        } else {
          return const Left('Read failed!');
        }
      } catch (e) {
        print('Server Error');
        return const Left('Server Error');
      }
    }
  }
}
