import 'dart:convert';

class SurveyScopeResponseModel {
  final List<ListDataScope> data;
  final int status;

  SurveyScopeResponseModel({
    required this.data,
    required this.status,
  });

  factory SurveyScopeResponseModel.fromJson(String str) =>
      SurveyScopeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyScopeResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyScopeResponseModel(
        data: List<ListDataScope>.from(
            json["data"].map((x) => ListDataScope.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ListDataScope {
  final int id;
  final String scope;

  ListDataScope({
    required this.id,
    required this.scope,
  });

  factory ListDataScope.fromJson(String str) =>
      ListDataScope.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListDataScope.fromMap(Map<String, dynamic> json) => ListDataScope(
        id: json["id"],
        scope: json["scope"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
      };
}
