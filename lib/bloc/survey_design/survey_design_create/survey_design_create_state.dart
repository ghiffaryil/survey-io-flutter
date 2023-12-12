part of 'survey_design_create_bloc.dart';

@freezed
class SurveyDesignCreateState with _$SurveyDesignCreateState {
  const factory SurveyDesignCreateState.initial() = _Initial;
  const factory SurveyDesignCreateState.loading() = _Loading;
  const factory SurveyDesignCreateState.loaded(Data data) = _Loaded;
  const factory SurveyDesignCreateState.error(String message) = _Error;
}
