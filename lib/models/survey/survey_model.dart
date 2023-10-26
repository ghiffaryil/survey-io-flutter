// ignore_for_file: non_constant_identifier_names

class SurveyModelData {
  final bool allowed;
  final int total_question;
  final List listSurvey;

  SurveyModelData({
    required this.allowed,
    required this.total_question,
    required this.listSurvey,
  });
}

class SurveyModelList {
  final int id;
  final String title;
  final int audience_id;
  final int user_id;
  final int survey_design_id;
  final String description;
  final String image_content;
  final String image_homescreen;
  final int point;
  final String survey_link;
  final String action_limit;
  final String type;
  final String source;
  final int energy;
  final int prods;
  final String slug;
  final dynamic report_link;
  final dynamic pdf_link;
  final String datetime_start;
  final String datetime_end;
  final String datetime_created;
  final String datetime_updated;
  final dynamic survey_question;

  SurveyModelList({
    required this.id,
    required this.title,
    required this.audience_id,
    required this.user_id,
    required this.survey_design_id,
    required this.description,
    required this.image_content,
    required this.image_homescreen,
    required this.point,
    required this.survey_link,
    required this.action_limit,
    required this.type,
    required this.source,
    required this.energy,
    required this.prods,
    required this.slug,
    required this.report_link,
    required this.pdf_link,
    required this.datetime_start,
    required this.datetime_end,
    required this.datetime_created,
    required this.datetime_updated,
    required this.survey_question,
  });
}
