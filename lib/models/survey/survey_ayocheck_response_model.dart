import 'dart:convert';

class SurveyAyoCheckResponseModel {
  final Data data;
  final int status;

  SurveyAyoCheckResponseModel({
    required this.data,
    required this.status,
  });

  factory SurveyAyoCheckResponseModel.fromJson(String str) =>
      SurveyAyoCheckResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyAyoCheckResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyAyoCheckResponseModel(
        data: Data.fromMap(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "status": status,
      };
}

class Data {
  final Survey survey;
  final bool allowed;
  final int? totalQuestion; // Mark as optional using the '?' symbol

  Data({
    required this.survey,
    required this.allowed,
    this.totalQuestion, // Mark as optional
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        survey: Survey.fromMap(json["survey"]),
        allowed: json["allowed"],
        totalQuestion: json["total_question"] as int?, // Mark as optional
      );

  Map<String, dynamic> toMap() => {
        "survey": survey.toMap(),
        "allowed": allowed,
        "total_question": totalQuestion, // Include as optional
      };
}

class Survey {
  final int id;
  final String title;
  final int audienceId;
  final int userId;
  final int surveyDesignId;
  final String? description; // Mark as optional
  final String? imageContent; // Mark as optional
  final String? imageHomescreen; // Mark as optional
  final int point;
  final String surveyLink;
  final String actionLimit;
  final String? type; // Mark as optional
  final String source;
  final int energy;
  final int prods;
  final String slug;
  final String? reportLink; // Mark as optional
  final String? accumulativeReportLink; // Mark as optional
  final String? pdfLink; // Mark as optional
  final DateTime datetimeStart;
  final DateTime datetimeEnd;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;
  final dynamic surveyQuestion; // Mark as optional

  Survey({
    required this.id,
    required this.title,
    required this.audienceId,
    required this.userId,
    required this.surveyDesignId,
    this.description,
    this.imageContent,
    this.imageHomescreen,
    required this.point,
    required this.surveyLink,
    required this.actionLimit,
    this.type,
    required this.source,
    required this.energy,
    required this.prods,
    required this.slug,
    this.reportLink,
    this.accumulativeReportLink,
    this.pdfLink,
    required this.datetimeStart,
    required this.datetimeEnd,
    required this.datetimeCreated,
    required this.datetimeUpdated,
    this.surveyQuestion,
  });

  factory Survey.fromJson(String str) => Survey.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Survey.fromMap(Map<String, dynamic> json) => Survey(
        id: json["id"],
        title: json["title"],
        audienceId: json["audience_id"],
        userId: json["user_id"],
        surveyDesignId: json["survey_design_id"],
        description: json["description"],
        imageContent: json["image_content"],
        imageHomescreen: json["image_homescreen"],
        point: json["point"],
        surveyLink: json["survey_link"],
        actionLimit: json["action_limit"],
        type: json["type"],
        source: json["source"],
        energy: json["energy"],
        prods: json["prods"],
        slug: json["slug"],
        reportLink: json["report_link"],
        accumulativeReportLink: json["accumulative_report_link"],
        pdfLink: json["pdf_link"],
        datetimeStart: DateTime.parse(json["datetime_start"]),
        datetimeEnd: DateTime.parse(json["datetime_end"]),
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
        surveyQuestion: json["survey_question"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "audience_id": audienceId,
        "user_id": userId,
        "survey_design_id": surveyDesignId,
        "description": description,
        "image_content": imageContent,
        "image_homescreen": imageHomescreen,
        "point": point,
        "survey_link": surveyLink,
        "action_limit": actionLimit,
        "type": type,
        "source": source,
        "energy": energy,
        "prods": prods,
        "slug": slug,
        "report_link": reportLink,
        "accumulative_report_link": accumulativeReportLink,
        "pdf_link": pdfLink,
        "datetime_start": datetimeStart.toIso8601String(),
        "datetime_end": datetimeEnd.toIso8601String(),
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
        "survey_question": surveyQuestion,
      };
}
