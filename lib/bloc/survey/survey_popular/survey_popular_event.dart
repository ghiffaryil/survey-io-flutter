part of 'survey_popular_bloc.dart';

@freezed
class SurveyPopularEvent with _$SurveyPopularEvent {
  const factory SurveyPopularEvent.started() = _Started;
  const factory SurveyPopularEvent.getSurveyPopular() = _GetSurveyPopular;
}