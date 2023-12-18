import 'dart:convert';

class DemographyRegionResponseModel {
  final List<ListDemographyRegion> data;
  final int status;

  DemographyRegionResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyRegionResponseModel.fromJson(String str) =>
      DemographyRegionResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyRegionResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyRegionResponseModel(
        data: List<ListDemographyRegion>.from(
            json["data"].map((x) => ListDemographyRegion.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyRegion {
  final int id;
  final String scope;
  final int price;

  ListDemographyRegion({
    required this.id,
    required this.scope,
    required this.price,
  });

  factory ListDemographyRegion.fromJson(String str) =>
      ListDemographyRegion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyRegion.fromMap(Map<String, dynamic> json) =>
      ListDemographyRegion(
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
