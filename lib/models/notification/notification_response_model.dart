import 'dart:convert';

class NotificationResponseModel {
  final List<NotificationList> data;
  final int status;

  NotificationResponseModel({
    required this.data,
    required this.status,
  });

  factory NotificationResponseModel.fromJson(String str) =>
      NotificationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationResponseModel.fromMap(Map<String, dynamic> json) =>
      NotificationResponseModel(
        data: List<NotificationList>.from(
            json["data"].map((x) => NotificationList.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class NotificationList {
  final int contentId;
  final String contentSource;
  final DateTime datetimeCreated;
  final int id;
  final String message;
  final int point;
  final String type;
  final int unread;
  final int userId;

  NotificationList({
    required this.contentId,
    required this.contentSource,
    required this.datetimeCreated,
    required this.id,
    required this.message,
    required this.point,
    required this.type,
    required this.unread,
    required this.userId,
  });

  factory NotificationList.fromJson(String str) =>
      NotificationList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationList.fromMap(Map<String, dynamic> json) =>
      NotificationList(
        contentId: json["content_id"],
        contentSource: json["content_source"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        id: json["id"],
        message: json["message"],
        point: json["point"],
        type: json["type"],
        unread: json["unread"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "content_id": contentId,
        "content_source": contentSource,
        "datetime_created": datetimeCreated.toIso8601String(),
        "id": id,
        "message": message,
        "point": point,
        "type": type,
        "unread": unread,
        "user_id": userId,
      };
}
