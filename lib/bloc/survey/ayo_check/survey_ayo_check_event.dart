part of 'survey_ayo_check_bloc.dart';

@freezed
class SurveyAyoCheckEvent with _$SurveyAyoCheckEvent {
  const factory SurveyAyoCheckEvent.started() = _Started;
  const factory SurveyAyoCheckEvent.getSurveyAyoCheck() = _GetSurveyAyoCheck;
}