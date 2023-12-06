part of 'survey_design_list_respondent_bloc.dart';

@freezed
class SurveyDesignListRespondentEvent with _$SurveyDesignListRespondentEvent {
  const factory SurveyDesignListRespondentEvent.started() = _Started;
  const factory SurveyDesignListRespondentEvent.getSurveyDesignListRespondent() = _GetSurveyDesignListRespondent;
}