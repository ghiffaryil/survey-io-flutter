import 'dart:convert';

class SurveyDesignCreateRequestModel {
  final String deviceId;
  final String type;
  final int respondent;
  final int totalQuestion;
  final int reportTime;
  final int totalScreener;
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
  final int isCalculate;

  SurveyDesignCreateRequestModel({
    required this.deviceId,
    required this.type,
    required this.respondent,
    required this.totalQuestion,
    required this.reportTime,
    required this.totalScreener,
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
      "monthly_income": monthlyIncome,
      "monthly_outcome": monthlyOutcome,
      "marital": marital,
      "occupation": occupation,
      "religion": religion,
      "region": region,
      "province": province,
      "city": city,
      "is_calculate": isCalculate
    };
  }

  factory SurveyDesignCreateRequestModel.fromMap(Map<String, dynamic> map) {
    return SurveyDesignCreateRequestModel(
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
      province: map['province'] ?? '',
      city: map['city'] ?? '',
      isCalculate: map['is_calculate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SurveyDesignCreateRequestModel.toJson(String source) =>
      SurveyDesignCreateRequestModel.fromMap(json.decode(source));
}
