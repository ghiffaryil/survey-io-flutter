part of 'survey_design_list_scope_bloc.dart';

@freezed
class SurveyDesignListScopeState with _$SurveyDesignListScopeState {
  const factory SurveyDesignListScopeState.initial() = _Initial;
  const factory SurveyDesignListScopeState.loading() = _Loading;
  const factory SurveyDesignListScopeState.loaded(List<ListDataScope> data) = _Loaded;
  const factory SurveyDesignListScopeState.error(String message) = _Error;
}
