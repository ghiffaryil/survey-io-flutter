part of 'survey_design_submit_bloc.dart';

@freezed
class SurveyDesignSubmitState with _$SurveyDesignSubmitState {
  const factory SurveyDesignSubmitState.initial() = _Initial;
  const factory SurveyDesignSubmitState.loading() = _Loading;
  const factory SurveyDesignSubmitState.loaded(String data) = _Loaded;
  const factory SurveyDesignSubmitState.error(String message) = _Error;
}
