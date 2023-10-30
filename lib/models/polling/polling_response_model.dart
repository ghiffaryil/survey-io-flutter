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
        data: List<PollingData>.from(
            json["data"].map((x) => PollingData.fromMap(x))),
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
  final Placement placement;
  final int totalVote;
  final bool allowed;

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
        polling: Polling.fromMap(json["polling"]),
        pollingList: List<PollingList>.from(
            json["polling_list"].map((x) => PollingList.fromMap(x))),
        placement: placementValues.map[json["placement"]]!,
        totalVote: json["total_vote"],
        allowed: json["allowed"],
      );

  Map<String, dynamic> toMap() => {
        "polling": polling.toMap(),
        "polling_list": List<dynamic>.from(pollingList.map((x) => x.toMap())),
        "placement": placementValues.reverse[placement],
        "total_vote": totalVote,
        "allowed": allowed,
      };
}

enum Placement { HORIZONTAL, VERTICAL }

final placementValues = EnumValues(
    {"horizontal": Placement.HORIZONTAL, "vertical": Placement.VERTICAL});

class Polling {
  final int id;
  final String title;
  final int audienceId;
  final String? description; // Mark as optional using the '?'
  final String? imageContent; // Mark as optional using the '?'
  final String? imageHomescreen; // Mark as optional using the '?'
  final int point;
  final ActionLimit actionLimit;
  final Type type;
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
        actionLimit:
            actionLimitValues.map[json["action_limit"]] ?? ActionLimit.ONCE,
        type: typeValues.map[json["type"]] ?? Type.EMPTY,
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
        "action_limit": actionLimitValues.reverse[actionLimit],
        "type": typeValues.reverse[type],
        "energy": energy,
        "prods": prods,
        "slug": slug,
        "datetime_start": datetimeStart.toIso8601String(),
        "datetime_end": datetimeEnd.toIso8601String(),
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
      };
}

enum ActionLimit { ONCE }

final actionLimitValues = EnumValues({"once": ActionLimit.ONCE});

enum Type { EMPTY, RECOMMENDED }

final typeValues =
    EnumValues({"": Type.EMPTY, "recommended": Type.RECOMMENDED});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
