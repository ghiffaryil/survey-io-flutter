part of 'survey_design_submit_bloc.dart';

@freezed
class SurveyDesignSubmitEvent with _$SurveyDesignSubmitEvent {
  const factory SurveyDesignSubmitEvent.started() = _Started;
  const factory SurveyDesignSubmitEvent.submitSurveyDesign(int surveyDesignId) = _SubmitSurveyDesign;
}