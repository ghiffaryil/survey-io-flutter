import 'dart:convert';

class SurveyDesignIsCalculateResponseModel {
  final Data data;
  final String message;
  final int status;

  SurveyDesignIsCalculateResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SurveyDesignIsCalculateResponseModel.fromJson(String str) =>
      SurveyDesignIsCalculateResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyDesignIsCalculateResponseModel.fromMap(
          Map<String, dynamic> json) =>
      SurveyDesignIsCalculateResponseModel(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "message": message,
        "status": status,
      };
}

class Data {
  final int point;
  final int price;

  Data({
    required this.point,
    required this.price,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        point: json["point"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "point": point,
        "price": price,
      };
}
