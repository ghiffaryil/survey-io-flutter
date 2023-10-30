part of 'survey_ayo_check_bloc.dart';

@freezed
class SurveyAyoCheckState with _$SurveyAyoCheckState {
  const factory SurveyAyoCheckState.initial() = _Initial;
  const factory SurveyAyoCheckState.loading() = _Loading;
  const factory SurveyAyoCheckState.loaded(Data surveyAyoCheck) = _Loaded;
  const factory SurveyAyoCheckState.error(String message) = _Error;
}
