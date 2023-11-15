import 'dart:convert';

class ReedemHistoryResponseModel {
  final List<ReedemHistoryList> data;
  final int status;

  ReedemHistoryResponseModel({
    required this.data,
    required this.status,
  });

  factory ReedemHistoryResponseModel.fromJson(String str) =>
      ReedemHistoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReedemHistoryResponseModel.fromMap(Map<String, dynamic> json) =>
      ReedemHistoryResponseModel(
        data: List<ReedemHistoryList>.from(
            json["data"].map((x) => ReedemHistoryList.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class ReedemHistoryList {
  final int id;
  final int userId;
  final String rewardSource;
  final int rewardId;
  final int point;
  final String productName;
  final int amount;
  final String message;
  final DateTime datetimeCreated;

  ReedemHistoryList({
    required this.id,
    required this.userId,
    required this.rewardSource,
    required this.rewardId,
    required this.point,
    required this.productName,
    required this.amount,
    required this.message,
    required this.datetimeCreated,
  });

  factory ReedemHistoryList.fromJson(String str) =>
      ReedemHistoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReedemHistoryList.fromMap(Map<String, dynamic> json) =>
      ReedemHistoryList(
        id: json["id"],
        userId: json["user_id"],
        rewardSource: json["reward_source"],
        rewardId: json["reward_id"],
        point: json["point"],
        productName: json["product_name"],
        amount: json["amount"],
        message: json["message"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "reward_source": rewardSource,
        "reward_id": rewardId,
        "point": point,
        "product_name": productName,
        "amount": amount,
        "message": message,
        "datetime_created": datetimeCreated.toIso8601String(),
      };
}
