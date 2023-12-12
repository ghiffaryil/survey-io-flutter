import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';
import '../../models/user/get_profile_response_model.dart';

class ProfileRemoteDatasource {
  Future<Either<String, ProfileResponseModel>> getProfile() async {
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
        print('Get Profile : success');
        // print(response.body);
        return Right(ProfileResponseModel.fromJson(response.body));
      } else {
        print('Get Profile : no data');
        return const Left('Can\'t Load data ');
      }
    } catch (e) {
      print('Get Profile : $e');
      return const Left('Server Error');
    }
  }
}
