// ignore_for_file: non_constant_identifier_names

class SurveyDesignModel {
  final int id;
  final int user_id;
  final String device_id;
  final String type;
  final int respondent;
  final int total_question;
  final dynamic age_start;
  final dynamic age_end;
  final dynamic children;
  final dynamic gender;
  final dynamic monthly_income;
  final dynamic monthly_outcome;
  final dynamic marital;
  final dynamic occupation;
  final dynamic religion;
  final dynamic region;
  final dynamic province;
  final dynamic city;
  final int report_time;
  final int total_screener;
  final int created;
  final int price;
  final int point;
  final String create_question_url;
  final String datetime_created;
  final String datetime_updated;
  final dynamic datetime_completed;
  final int survey_id;
  final dynamic pdf_link;
  final String respondent_progress;

  SurveyDesignModel({
    required this.id,
    required this.user_id,
    required this.device_id,
    required this.type,
    required this.respondent,
    required this.total_question,
    required this.age_start,
    required this.age_end,
    required this.children,
    required this.gender,
    required this.monthly_income,
    required this.monthly_outcome,
    required this.marital,
    required this.occupation,
    required this.religion,
    required this.region,
    required this.province,
    required this.city,
    required this.report_time,
    required this.total_screener,
    required this.created,
    required this.price,
    required this.point,
    required this.create_question_url,
    required this.datetime_created,
    required this.datetime_updated,
    required this.datetime_completed,
    required this.survey_id,
    required this.pdf_link,
    required this.respondent_progress,
  });
}
