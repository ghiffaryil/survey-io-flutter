part of 'survey_popular_bloc.dart';

@freezed
class SurveyPopularState with _$SurveyPopularState {
  const factory SurveyPopularState.initial() = _Initial;
  const factory SurveyPopularState.loading() = _Loading;
  const factory SurveyPopularState.loaded(List<SurveyListData> data) = _Loaded;
  const factory SurveyPopularState.error(String message) = _Error;
}
