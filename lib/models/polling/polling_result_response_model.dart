import 'dart:convert';

class PollingResultResponseModel {
  final List<PollingResultList> data;
  final int status;

  PollingResultResponseModel({
    required this.data,
    required this.status,
  });

  factory PollingResultResponseModel.fromJson(String str) =>
      PollingResultResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingResultResponseModel.fromMap(Map<String, dynamic> json) =>
      PollingResultResponseModel(
        data: List<PollingResultList>.from(
            json["data"].map((x) => PollingResultList.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class PollingResultList {
  final int pollingListId;
  final int count;

  PollingResultList({
    required this.pollingListId,
    required this.count,
  });

  factory PollingResultList.fromJson(String str) =>
      PollingResultList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingResultList.fromMap(Map<String, dynamic> json) =>
      PollingResultList(
        pollingListId: json["polling_list_id"],
        count: json["count"],
      );

  Map<String, dynamic> toMap() => {
        "polling_list_id": pollingListId,
        "count": count,
      };
}
