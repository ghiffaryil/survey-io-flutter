import 'dart:convert';

class DemographyAgeResponseModel {
  final List<ListDemographyAge> data;
  final int status;

  DemographyAgeResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyAgeResponseModel.fromJson(String str) =>
      DemographyAgeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyAgeResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyAgeResponseModel(
        data: List<ListDemographyAge>.from(
            json["data"].map((x) => ListDemographyAge.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyAge {
  final int id;
  final String scope;

  ListDemographyAge({
    required this.id,
    required this.scope,
  });

  factory ListDemographyAge.fromJson(String str) =>
      ListDemographyAge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyAge.fromMap(Map<String, dynamic> json) =>
      ListDemographyAge(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
