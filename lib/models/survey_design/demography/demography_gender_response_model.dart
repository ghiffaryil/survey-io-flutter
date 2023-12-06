import 'dart:convert';

class DemographyGenderResponseModel {
  final List<ListDemographyGender> data;
  final int status;

  DemographyGenderResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyGenderResponseModel.fromJson(String str) =>
      DemographyGenderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyGenderResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyGenderResponseModel(
        data: List<ListDemographyGender>.from(
            json["data"].map((x) => ListDemographyGender.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyGender {
  final int id;
  final String scope;

  ListDemographyGender({
    required this.id,
    required this.scope,
  });

  factory ListDemographyGender.fromJson(String str) =>
      ListDemographyGender.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyGender.fromMap(Map<String, dynamic> json) =>
      ListDemographyGender(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
