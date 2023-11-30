import 'dart:convert';

class ListCityResponseModel {
  final List<DataCity> data;
  final int status;

  ListCityResponseModel({
    required this.data,
    required this.status,
  });

  factory ListCityResponseModel.fromJson(String str) =>
      ListCityResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListCityResponseModel.fromMap(Map<String, dynamic> json) =>
      ListCityResponseModel(
        data: List<DataCity>.from(json["data"].map((x) => DataCity.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class DataCity {
  final int id;
  final int provinceListId;
  final String name;

  DataCity({
    required this.id,
    required this.provinceListId,
    required this.name,
  });

  factory DataCity.fromJson(String str) => DataCity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataCity.fromMap(Map<String, dynamic> json) => DataCity(
        id: json["id"],
        provinceListId: json["province_list_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "province_list_id": provinceListId,
        "name": name,
      };
}
