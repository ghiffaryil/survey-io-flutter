import 'dart:convert';

class DemographyOutcomeResponseModel {
  final List<ListDemographyOutcome> data;
  final int status;

  DemographyOutcomeResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyOutcomeResponseModel.fromJson(String str) =>
      DemographyOutcomeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyOutcomeResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyOutcomeResponseModel(
        data: List<ListDemographyOutcome>.from(
            json["data"].map((x) => ListDemographyOutcome.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyOutcome {
  final int id;
  final String scope;

  ListDemographyOutcome({
    required this.id,
    required this.scope,
  });

  factory ListDemographyOutcome.fromJson(String str) =>
      ListDemographyOutcome.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyOutcome.fromMap(Map<String, dynamic> json) =>
      ListDemographyOutcome(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
