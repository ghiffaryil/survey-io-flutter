import 'dart:convert';

class DemographyChildrenResponseModel {
    final List<ListDemographyChildren> data;
    final int status;

    DemographyChildrenResponseModel({
        required this.data,
        required this.status,
    });

    factory DemographyChildrenResponseModel.fromJson(String str) => DemographyChildrenResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DemographyChildrenResponseModel.fromMap(Map<String, dynamic> json) => DemographyChildrenResponseModel(
        data: List<ListDemographyChildren>.from(json["data"].map((x) => ListDemographyChildren.fromMap(x))),
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
    };
}

class ListDemographyChildren {
    final int id;
    final String scope;

    ListDemographyChildren({
        required this.id,
        required this.scope,
    });

    factory ListDemographyChildren.fromJson(String str) => ListDemographyChildren.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListDemographyChildren.fromMap(Map<String, dynamic> json) => ListDemographyChildren(
        id: json["id"],
        scope: json["scope"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "scope": scope,
    };
}
