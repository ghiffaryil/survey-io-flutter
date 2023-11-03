import 'dart:convert';

class PollingDoneResponseModel {
  final List<PollingDone> data;
  final int status;

  PollingDoneResponseModel({
    required this.data,
    required this.status,
  });

  factory PollingDoneResponseModel.fromJson(String str) =>
      PollingDoneResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingDoneResponseModel.fromMap(Map<String, dynamic> json) =>
      PollingDoneResponseModel(
        data: List<PollingDone>.from(
            json["data"].map((x) => PollingDone.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class PollingDone {
  final Polling polling;
  final List<PollingList> pollingList;
  final String placement;
  final int totalVote;
  final int answer;

  PollingDone({
    required this.polling,
    required this.pollingList,
    required this.placement,
    required this.totalVote,
    required this.answer,
  });

  factory PollingDone.fromJson(String str) =>
      PollingDone.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollingDone.fromMap(Map<String, dynamic> json) => PollingDone(
        polling: Polling.fromMap(json["polling"]),
        pollingList: List<PollingList>.from(
            json["polling_list"].map((x) => PollingList.fromMap(x))),
        placement: json["placement"],
        totalVote: json["total_vote"],
        answer: json["answer"],
      );

  Map<String, dynamic> toMap() => {
        "polling": polling.toMap(),
        "polling_list": List<dynamic>.from(pollingList.map((x) => x.toMap())),
        "placement": placement,
        "total_vote": totalVote,
        "answer": answer,
      };
}

class Polling {
  final int id;
  final String title;
  final int audienceId;
  final String description;
  final String imageContent;
  final String imageHomescreen;
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
        id: json["id"],
        title: json["title"],
        audienceId: json["audience_id"],
        description: json["description"],
        imageContent: json["image_content"],
        imageHomescreen: json["image_homescreen"],
        point: json["point"],
        actionLimit: json["action_limit"],
        type: json["type"],
        energy: json["energy"],
        prods: json["prods"],
        slug: json["slug"],
        datetimeStart: DateTime.parse(json["datetime_start"]),
        datetimeEnd: DateTime.parse(json["datetime_end"]),
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
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
