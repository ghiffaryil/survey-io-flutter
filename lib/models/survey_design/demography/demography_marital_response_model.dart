import 'dart:convert';

class DemographyMaritalResponseModel {
  final List<ListDemographyMarital> data;
  final int status;

  DemographyMaritalResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyMaritalResponseModel.fromJson(String str) =>
      DemographyMaritalResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyMaritalResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyMaritalResponseModel(
        data: List<ListDemographyMarital>.from(
            json["data"].map((x) => ListDemographyMarital.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyMarital {
  final int id;
  final String scope;

  ListDemographyMarital({
    required this.id,
    required this.scope,
  });

  factory ListDemographyMarital.fromJson(String str) =>
      ListDemographyMarital.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyMarital.fromMap(Map<String, dynamic> json) =>
      ListDemographyMarital(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
