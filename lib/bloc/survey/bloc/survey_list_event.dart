part of 'survey_list_bloc.dart';

@freezed
class SurveyListEvent with _$SurveyListEvent {
  const factory SurveyListEvent.started() = _Started;
  const factory SurveyListEvent.getSurveyList() = _GetSurveyList;
}