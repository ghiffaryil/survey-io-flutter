// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../models/messages_model.dart';


// class Repository {
//   final _baseUrl = 'https://65236495f43b179384155d29.mockapi.io/api/MessagesModel';
//   Future getList() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         // print(response.body);
//         Iterable it = jsonDecode(response.body);
//         List<MessagesModel> lisMmessages = it.map((e) => MessagesModel.fromJson(e)).toList();
//         return lisMmessages;
//       } else {
//         // Handle non-200 status code (optional)
//         print('HTTP Status Code: ${response.statusCode}');
//         return null; // Return null when the response code is not 200.
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
