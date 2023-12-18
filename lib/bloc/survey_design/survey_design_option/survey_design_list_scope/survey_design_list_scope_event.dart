part of 'survey_design_list_scope_bloc.dart';

@freezed
class SurveyDesignListScopeEvent with _$SurveyDesignListScopeEvent {
  const factory SurveyDesignListScopeEvent.started() = _Started;
  const factory SurveyDesignListScopeEvent.getSurveyDesignListScope() = _GetSurveyDesignListScope;
}