import 'dart:convert';

class DemographyReligionResponseModel {
  final List<ListDemographyReligion> data;
  final int status;

  DemographyReligionResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyReligionResponseModel.fromJson(String str) =>
      DemographyReligionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyReligionResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyReligionResponseModel(
        data: List<ListDemographyReligion>.from(
            json["data"].map((x) => ListDemographyReligion.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyReligion {
  final int id;
  final String scope;
  final int price;

  ListDemographyReligion({
    required this.id,
    required this.scope,
    required this.price,
  });

  factory ListDemographyReligion.fromJson(String str) =>
      ListDemographyReligion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyReligion.fromMap(Map<String, dynamic> json) =>
      ListDemographyReligion(
        id: json["id"],
        scope: json["scope"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
        "price": price,
      };
}
