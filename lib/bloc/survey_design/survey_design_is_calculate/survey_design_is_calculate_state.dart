part of 'survey_design_is_calculate_bloc.dart';

@freezed
class SurveyDesignIsCalculateState with _$SurveyDesignIsCalculateState {
  const factory SurveyDesignIsCalculateState.initial() = _Initial;
  const factory SurveyDesignIsCalculateState.loading() = _Loading;
  const factory SurveyDesignIsCalculateState.loaded(Data data) = _Loaded;
  const factory SurveyDesignIsCalculateState.error(String message) = _Error;
}
