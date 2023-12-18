import 'dart:convert';

class SurveyRespondentResponseModel {
    final List<ListDataRespondent> data;
    final int status;

    SurveyRespondentResponseModel({
        required this.data,
        required this.status,
    });

    factory SurveyRespondentResponseModel.fromJson(String str) => SurveyRespondentResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SurveyRespondentResponseModel.fromMap(Map<String, dynamic> json) => SurveyRespondentResponseModel(
        data: List<ListDataRespondent>.from(json["data"].map((x) => ListDataRespondent.fromMap(x))),
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
    };
}

class ListDataRespondent {
    final int id;
    final int scope;

    ListDataRespondent({
        required this.id,
        required this.scope,
    });

    factory ListDataRespondent.fromJson(String str) => ListDataRespondent.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListDataRespondent.fromMap(Map<String, dynamic> json) => ListDataRespondent(
        id: json["id"],
        scope: json["scope"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
    };
}
