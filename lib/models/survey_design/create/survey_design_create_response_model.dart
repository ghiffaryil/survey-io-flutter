import 'dart:convert';

class SurveyDesignCreateResponseModel {
  final Data data;
  final String message;
  final int status;

  SurveyDesignCreateResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SurveyDesignCreateResponseModel.fromJson(String str) =>
      SurveyDesignCreateResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurveyDesignCreateResponseModel.fromMap(Map<String, dynamic> json) =>
      SurveyDesignCreateResponseModel(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "message": message,
        "status": status,
      };
}

class Data {
  final int id;
  final int userId;
  final String deviceId;
  final String type;
  final int respondent;
  final int totalQuestion;
  final int ageStart;
  final int ageEnd;
  final String children;
  final String gender;
  final String monthlyIncome;
  final String monthlyOutcome;
  final String marital;
  final String occupation;
  final String religion;
  final String region;
  final String province;
  final String city;
  final int reportTime;
  final int totalScreener;
  final int created;
  final int price;
  final int point;
  final String createQuestionUrl;
  final DateTime datetimeCreated;
  final DateTime datetimeUpdated;
  final dynamic datetimeCompleted;

  Data({
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
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        type: json["type"],
        respondent: json["respondent"],
        totalQuestion: json["total_question"],
        ageStart: json["age_start"],
        ageEnd: json["age_end"],
        children: json["children"],
        gender: json["gender"],
        monthlyIncome: json["monthly_income"],
        monthlyOutcome: json["monthly_outcome"],
        marital: json["marital"],
        occupation: json["occupation"],
        religion: json["religion"],
        region: json["region"],
        province: json["province"],
        city: json["city"],
        reportTime: json["report_time"],
        totalScreener: json["total_screener"],
        created: json["created"],
        price: json["price"],
        point: json["point"],
        createQuestionUrl: json["create_question_url"],
        datetimeCreated: DateTime.parse(json["datetime_created"]),
        datetimeUpdated: DateTime.parse(json["datetime_updated"]),
        datetimeCompleted: json["datetime_completed"],
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
        "datetime_completed": datetimeCompleted,
      };
}
