part of 'survey_design_list_respondent_bloc.dart';

@freezed
class SurveyDesignListRespondentState with _$SurveyDesignListRespondentState {
  const factory SurveyDesignListRespondentState.initial() = _Initial;
  const factory SurveyDesignListRespondentState.loading() = _Loading;
  const factory SurveyDesignListRespondentState.loaded(List<ListDataRespondent> data) = _Loaded;
  const factory SurveyDesignListRespondentState.error(String message) = _Error;
}
