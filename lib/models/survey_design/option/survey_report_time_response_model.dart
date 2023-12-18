import 'dart:convert';

class SurveyReportTimeResponseModel {
  final List<ListDataReportTime> data;
  final int status;

  SurveyReportTimeResponseModel({
    required this.data,
    required this.status,
  });

  factory SurveyReportTimeResponseModel.fromJson(String str) =>
      SurveyReportTimeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyReportTimeResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyReportTimeResponseModel(
        data: List<ListDataReportTime>.from(
            json["data"].map((x) => ListDataReportTime.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDataReportTime {
  final int id;
  final String scope;
  final int price;
  final String label;

  ListDataReportTime({
    required this.id,
    required this.scope,
    required this.price,
    required this.label,
  });

  factory ListDataReportTime.fromJson(String str) =>
      ListDataReportTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDataReportTime.fromMap(Map<String, dynamic> json) =>
      ListDataReportTime(
        id: json["id"],
        scope: json["scope"],
        price: json["price"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
        "price": price,
        "label": label,
      };
}
