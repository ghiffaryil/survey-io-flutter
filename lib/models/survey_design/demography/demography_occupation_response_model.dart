import 'dart:convert';

class DemographyOccupationResponseModel {
  final List<ListDemographyOccupation> data;
  final int status;

  DemographyOccupationResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyOccupationResponseModel.fromJson(String str) =>
      DemographyOccupationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyOccupationResponseModel.fromMap(
          Map<String, dynamic> json) =>
      DemographyOccupationResponseModel(
        data: List<ListDemographyOccupation>.from(
            json["data"].map((x) => ListDemographyOccupation.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyOccupation {
  final int id;
  final String scope;
  final int price;

  ListDemographyOccupation({
    required this.id,
    required this.scope,
    required this.price,
  });

  factory ListDemographyOccupation.fromJson(String str) =>
      ListDemographyOccupation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyOccupation.fromMap(Map<String, dynamic> json) =>
      ListDemographyOccupation(
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
