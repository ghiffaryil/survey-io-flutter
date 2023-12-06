import 'dart:convert';

class DemographyIncomeResponseModel {
  final List<ListDemographyIncome> data;
  final int status;

  DemographyIncomeResponseModel({
    required this.data,
    required this.status,
  });

  factory DemographyIncomeResponseModel.fromJson(String str) =>
      DemographyIncomeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DemographyIncomeResponseModel.fromMap(Map<String, dynamic> json) =>
      DemographyIncomeResponseModel(
        data: List<ListDemographyIncome>.from(
            json["data"].map((x) => ListDemographyIncome.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDemographyIncome {
  final int id;
  final String scope;

  ListDemographyIncome({
    required this.id,
    required this.scope,
  });

  factory ListDemographyIncome.fromJson(String str) =>
      ListDemographyIncome.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDemographyIncome.fromMap(Map<String, dynamic> json) =>
      ListDemographyIncome(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
