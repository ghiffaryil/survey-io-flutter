import 'dart:convert';

class SurveyDesignListResponseModel {
  final List<SurveyDesignList> data;
  final int status;

  SurveyDesignListResponseModel({
    required this.data,
    required this.status,
  });

  factory SurveyDesignListResponseModel.fromJson(String str) =>
      SurveyDesignListResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyDesignListResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyDesignListResponseModel(
        data: List<SurveyDesignList>.from(
            json["data"].map((x) => SurveyDesignList.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "status": status,
      };
}

class SurveyDesignList {
  final int id;
  final int userId;
  final String deviceId;
  final String type;
  final int respondent;
  final int totalQuestion;
  final int? ageStart;
  final int? ageEnd;
  final String? children;
  final String? gender;
  final String? monthlyIncome;
  final String? monthlyOutcome;
  final String? marital;
  final String? occupation;
  final String? religion;
  final String? region;
  final String? province;
  final String? city;
  final int reportTime;
  final int totalScreener;
  final int created;
  final int price;
  final int point;
  final String createQuestionUrl;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;
  final DateTime? datetimeCompleted;
  final int surveyId;
  final String? pdfLink;
  final String respondentProgress;

  SurveyDesignList({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.type,
    required this.respondent,
    required this.totalQuestion,
    required this.ageStart,
    required this.ageEnd,
    required this.children,
    required this.gender,
    required this.monthlyIncome,
    required this.monthlyOutcome,
    required this.marital,
    required this.occupation,
    required this.religion,
    required this.region,
    required this.province,
    required this.city,
    required this.reportTime,
    required this.totalScreener,
    required this.created,
    required this.price,
    required this.point,
    required this.createQuestionUrl,
    required this.datetimeCreated,
    required this.datetimeUpdated,
    required this.datetimeCompleted,
    required this.surveyId,
    required this.pdfLink,
    required this.respondentProgress,
  });

  factory SurveyDesignList.fromJson(String str) =>
      SurveyDesignList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyDesignList.fromMap(Map<String, dynamic> json) =>
      SurveyDesignList(
        id: json["id"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        type: json["type"],
        respondent: json["respondent"],
        totalQuestion: json["total_question"],
        ageStart: json["age_start"] ?? 0,
        ageEnd: json["age_end"] ?? 0,
        children: json["children"] ?? "Semua",
        gender: json["gender"] ?? "Semua",
        monthlyIncome: json["monthly_income"] ?? "Semua",
        monthlyOutcome: json["monthly_outcome"] ?? "Semua",
        marital: json["marital"] ?? "Semua",
        occupation: json["occupation"] ?? "Semua",
        religion: json["religion"] ?? "Semua",
        region: json["region"] ?? "Semua",
        province: json["province"] ?? "Semua",
        city: json["city"] ?? "Semua",
        reportTime: json["report_time"],
        totalScreener: json["total_screener"],
        created: json["created"],
        price: json["price"],
        point: json["point"],
        createQuestionUrl: json["create_question_url"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
        datetimeCompleted: json["datetime_completed"] == null
            ? null
            : DateTime.parse(json["datetime_completed"]),
        surveyId: json["survey_id"],
        pdfLink: json["pdf_link"],
        respondentProgress: json["respondent_progress"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "device_id": deviceId,
        "type": type,
        "respondent": respondent,
        "total_question": totalQuestion,
        "age_start": ageStart,
        "age_end": ageEnd,
        "children": children,
        "gender": gender,
        "monthly_income": monthlyIncome,
        "monthly_outcome": monthlyOutcome,
        "marital": marital,
        "occupation": occupation,
        "religion": religion,
        "region": region,
        "province": province,
        "city": city,
        "report_time": reportTime,
        "total_screener": totalScreener,
        "created": created,
        "price": price,
        "point": point,
        "create_question_url": createQuestionUrl,
        "datetime_created": datetimeCreated.toIso8601String(),
        "datetime_updated": datetimeUpdated.toIso8601String(),
        "datetime_completed": datetimeCompleted?.toIso8601String(),
        "survey_id": surveyId,
        "pdf_link": pdfLink,
        "respondent_progress": respondentProgress,
      };
}
