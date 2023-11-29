import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:survey_io/models/reedem/product_prepaid_response_model.dart';

import '../login/auth_save_local_datasource.dart';
import '../../../common/constants/variables.dart';

class ProductPrepaidListDatasource {
  Future<Either<String, ProductPrepaidResponseModel>>
      getListProductPrepaid() async {
    final token = await AuthLocalDatasource().getToken();

    if (token.isEmpty) {
      return const Left('No access token available');
    }

    final headers = {'authorization': token};
    final response = await http.get(
      Uri.parse('${Variables.baseURL}/redeem/product/prepaid'),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        print('Get List Product Prepaid : success');
        print(response.body);
        return Right(ProductPrepaidResponseModel.fromJson(response.body));
      } else {
        print('Get List Product Prepaid : no data');
        return const Left('Can\'t Load data ');
      }
    } catch (e) {
      print('Get List Product Prepaid : $e');
      return const Left('Server Error');
    }
  }
}
