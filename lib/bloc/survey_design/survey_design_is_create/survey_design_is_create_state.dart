part of 'survey_design_is_create_bloc.dart';

@freezed
class SurveyDesignIsCreateState with _$SurveyDesignIsCreateState {
  const factory SurveyDesignIsCreateState.initial() = _Initial;
  const factory SurveyDesignIsCreateState.loading() = _Loading;
  const factory SurveyDesignIsCreateState.loaded(String data) = _Loaded;
  const factory SurveyDesignIsCreateState.error(String message) = _Error;
}
