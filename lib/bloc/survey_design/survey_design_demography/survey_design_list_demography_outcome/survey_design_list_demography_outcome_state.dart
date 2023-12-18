part of 'survey_design_list_demography_outcome_bloc.dart';

@freezed
class SurveyDesignListDemographyOutcomeState with _$SurveyDesignListDemographyOutcomeState {
  const factory SurveyDesignListDemographyOutcomeState.initial() = _Initial;
  const factory SurveyDesignListDemographyOutcomeState.loading() = _Loading;
  const factory SurveyDesignListDemographyOutcomeState.loaded(List<ListDemographyOutcome> data) = _Loaded;
  const factory SurveyDesignListDemographyOutcomeState.error(String message) = _Error;
}
