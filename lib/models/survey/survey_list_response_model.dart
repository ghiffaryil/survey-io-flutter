import 'dart:convert';

class SurveyListResponseModel {
  final List<SurveyListData> data;
  final int status;

  SurveyListResponseModel({
    required this.data,
    required this.status,
  });

  factory SurveyListResponseModel.fromJson(String str) =>
      SurveyListResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyListResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyListResponseModel(
        data: List<SurveyListData>.from(
            json["data"].map((x) => SurveyListData.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class SurveyListData {
  final Survey survey;
  final bool allowed;
  final int totalQuestion;

  SurveyListData({
    required this.survey,
    required this.allowed,
    required this.totalQuestion,
  });

  factory SurveyListData.fromJson(String str) =>
      SurveyListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyListData.fromMap(Map<String, dynamic> json) => SurveyListData(
        survey: Survey.fromMap(json["survey"]),
        allowed: json["allowed"],
        totalQuestion: json["total_question"],
      );

  Map<String, dynamic> toMap() => {
        "survey": survey.toMap(),
        "allowed": allowed,
        "total_question": totalQuestion,
      };
}

class Survey {
  final int id;
  final String title;
  final int audienceId;
  final int userId;
  final int surveyDesignId;
  final String description;
  final String imageContent;
  final String imageHomescreen;
  final int point;
  final String surveyLink;
  final String actionLimit;
  final String type;
  final String source;
  final int energy;
  final int prods;
  final String slug;
  final String? reportLink; // Changed to nullable
  final String? accumulativeReportLink; // Changed to nullable
  final String? pdfLink; // Changed to nullable
  final DateTime datetimeStart;
  final DateTime datetimeEnd;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;
  final dynamic surveyQuestion; // Changed to dynamic

  Survey({
    required this.id,
    required this.title,
    required this.audienceId,
    required this.userId,
    required this.surveyDesignId,
    required this.description,
    required this.imageContent,
    required this.imageHomescreen,
    required this.point,
    required this.surveyLink,
    required this.actionLimit,
    required this.type,
    required this.source,
    required this.energy,
    required this.prods,
    required this.slug,
    this.reportLink, // Changed to nullable
    this.accumulativeReportLink, // Changed to nullable
    this.pdfLink, // Changed to nullable
    required this.datetimeStart,
    required this.datetimeEnd,
    required this.datetimeCreated,
    required this.datetimeUpdated,
    this.surveyQuestion, // Changed to dynamic
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
        "energy": energy,
        "prods": prods,
        "slug": slug,
        "datetime_start": datetimeStart.toIso8601String(),
        "datetime_end": datetimeEnd.toIso8601String(),
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
        "survey_question": surveyQuestion,
      };
}
