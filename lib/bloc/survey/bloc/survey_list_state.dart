part of 'survey_list_bloc.dart';

@freezed
class SurveyListState with _$SurveyListState {
  const factory SurveyListState.initial() = _Initial;
  const factory SurveyListState.loading() = _Loading;
  const factory SurveyListState.loaded(List<SurveyListData> surveyList) = _Loaded;
  const factory SurveyListState.error(String message) = _Error;
}
