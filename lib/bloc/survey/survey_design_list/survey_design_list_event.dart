part of 'survey_design_list_bloc.dart';

@freezed
class SurveyDesignListEvent with _$SurveyDesignListEvent {
  const factory SurveyDesignListEvent.started() = _Started;
  const factory SurveyDesignListEvent.getSurveyDesignList() = _GetSurveyDesignList;
}