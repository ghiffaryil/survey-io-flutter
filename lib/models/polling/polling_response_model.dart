// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class PollingResponseModel {
  final List<PollingData> data;
  final int status;

  PollingResponseModel({
    required this.data,
    required this.status,
  });

  factory PollingResponseModel.fromJson(String str) =>
      PollingResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingResponseModel.fromMap(Map<String, dynamic> json) =>
      PollingResponseModel(
        data: (json["data"] as List<dynamic>?)!
            .map((x) => PollingData.fromMap(x))
            .toList(),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class PollingData {
  final Polling polling;
  final List<PollingList> pollingList;
  final String placement;
  final int totalVote;
  bool allowed;

  PollingData({
    required this.polling,
    required this.pollingList,
    required this.placement,
    required this.totalVote,
    required this.allowed,
  });

  factory PollingData.fromJson(String str) =>
      PollingData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory PollingData.fromMap(Map<String, dynamic> json) => PollingData(
        polling:
            Polling.fromMap(json["polling"] as Map<String, dynamic>? ?? {}),
        pollingList: (json["polling_list"] as List<dynamic>?)
                ?.map((x) => PollingList.fromMap(x))
                .toList() ??
            [],
        placement: json["placement"],
        totalVote: json["total_vote"] ?? 0,
        allowed: json["allowed"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "polling": polling.toMap(),
        "polling_list": List<dynamic>.from(pollingList.map((x) => x.toMap())),
        "placement": placement,
        "total_vote": totalVote,
        "allowed": allowed,
      };
}

class Polling {
  final int id;
  final String title;
  final int audienceId;
  final String? description;
  final String? imageContent;
  final String? imageHomescreen;
  final int point;
  final String actionLimit;
  final String type;
  final int energy;
  final int prods;
  final String slug;
  final DateTime datetimeStart;
  final DateTime datetimeEnd;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;

  Polling({
    required this.id,
    required this.title,
    required this.audienceId,
    required this.description,
    required this.imageContent,
    required this.imageHomescreen,
    required this.point,
    required this.actionLimit,
    required this.type,
    required this.energy,
    required this.prods,
    required this.slug,
    required this.datetimeStart,
    required this.datetimeEnd,
    required this.datetimeCreated,
    required this.datetimeUpdated,
  });

  factory Polling.fromJson(String str) => Polling.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Polling.fromMap(Map<String, dynamic> json) => Polling(
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        audienceId: json["audience_id"] ?? 0,
        description: json["description"] ?? "",
        imageContent: json["image_content"] ?? "",
        imageHomescreen: json["image_homescreen"] ?? "",
        point: json["point"] ?? 0,
        actionLimit: json["action_limit"] ?? 'once',
        type: json["type"] ?? '',
        energy: json["energy"] ?? 0,
        prods: json["prods"] ?? 0,
        slug: json["slug"] ?? "",
        datetimeStart: DateTime.parse(
            json["datetime_start"] ?? "1970-01-01T00:00:00+00:00"),
        datetimeEnd:
            DateTime.parse(json["datetime_end"] ?? "1970-01-01T00:00:00+00:00"),
        datetimeCreated: DateTime.parse(
            json["datetime_created"] ?? "1970-01-01T00:00:00+00:00"),
        datetimeUpdated: DateTime.parse(
            json["datetime_updated"] ?? "1970-01-01T00:00:00+00:00"),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "audience_id": audienceId,
        "description": description,
        "image_content": imageContent,
        "image_homescreen": imageHomescreen,
        "point": point,
        "action_limit": actionLimit,
        "type": type,
        "energy": energy,
        "prods": prods,
        "slug": slug,
        "datetime_start": datetimeStart.toIso8601String(),
        "datetime_end": datetimeEnd.toIso8601String(),
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
      };
}

class PollingList {
  final int id;
  final int pollingId;
  final String label;

  PollingList({
    required this.id,
    required this.pollingId,
    required this.label,
  });

  factory PollingList.fromJson(String str) =>
      PollingList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingList.fromMap(Map<String, dynamic> json) => PollingList(
        id: json["id"],
        pollingId: json["polling_id"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "polling_id": pollingId,
        "label": label,
      };
}
