import 'dart:convert';

class SurveyDesignIsCreateRequestModel {
  final String deviceId;
  final String type;
  final int respondent;
  final int totalQuestion;
  final int reportTime;
  final int totalScreener;
  final int ageStart;
  final int ageEnd;
  final String? children;
  final String? gender;
  final String? monthlyIncome;
  final String? monthlyOutcome;
  final String? marital;
  final String? occupation;
  final String? religion;
  final String? region;
  final int isCalculate;

  SurveyDesignIsCreateRequestModel({
    required this.deviceId,
    required this.type,
    required this.respondent,
    required this.totalQuestion,
    required this.reportTime,
    required this.totalScreener,
    required this.ageStart,
    required this.ageEnd,
    this.children,
    this.gender,
    this.monthlyIncome,
    this.monthlyOutcome,
    this.marital,
    this.occupation,
    this.religion,
    this.region,
    required this.isCalculate,
  });

  Map<String, dynamic> toMap() {
    return {
      "device_id": deviceId,
      "type": type,
      "respondent": respondent,
      "total_question": totalQuestion,
      "report_time": reportTime,
      "total_screener": totalScreener,
      "age_start": ageStart,
      "age_end": ageEnd,
      "children": children,
      "gender": gender,
      "marital": marital,
      "occupation": occupation,
      "region": region,
      "religion": religion,
      "monthly_income": monthlyIncome,
      "monthly_outcome": monthlyOutcome,
      "is_calculate": isCalculate
    };
  }

  factory SurveyDesignIsCreateRequestModel.fromMap(Map<String, dynamic> map) {
    return SurveyDesignIsCreateRequestModel(
      deviceId: map['device_id'] ?? '',
      type: map['type'] ?? '',
      respondent: map['respondent'] ?? '',
      totalQuestion: map['total_question'] ?? '',
      reportTime: map['report_time'] ?? '',
      totalScreener: map['total_screener'] ?? '',
      ageStart: map['age_start'] ?? '',
      ageEnd: map['age_end'] ?? '',
      children: map['children'] ?? '',
      gender: map['gender'] ?? '',
      monthlyIncome: map['monthly_income'] ?? '',
      monthlyOutcome: map['monthly_outcome'] ?? '',
      marital: map['marital'] ?? '',
      occupation: map['occupation'] ?? '',
      religion: map['religion'] ?? '',
      region: map['region'] ?? '',
      isCalculate: map['is_calculate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SurveyDesignIsCreateRequestModel.toJson(String source) =>
      SurveyDesignIsCreateRequestModel.fromMap(json.decode(source));
}
