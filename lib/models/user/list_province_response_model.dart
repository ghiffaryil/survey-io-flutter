import 'dart:convert';

class ListProvinceResponseModel {
    final List<DataProvince> data;
    final int status;

    ListProvinceResponseModel({
        required this.data,
        required this.status,
    });

    factory ListProvinceResponseModel.fromJson(String str) => ListProvinceResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ListProvinceResponseModel.fromMap(Map<String, dynamic> json) => ListProvinceResponseModel(
        data: List<DataProvince>.from(json["data"].map((x) => DataProvince.fromMap(x))),
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
    };
}

class DataProvince {
    final int id;
    final String name;
    final int regionId;

    DataProvince({
        required this.id,
        required this.name,
        required this.regionId,
    });

    factory DataProvince.fromJson(String str) => DataProvince.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DataProvince.fromMap(Map<String, dynamic> json) => DataProvince(
        id: json["id"],
        name: json["name"],
        regionId: json["region_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "region_id": regionId,
    };
}
