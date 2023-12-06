part of 'survey_design_list_demography_age_bloc.dart';

@freezed
class SurveyDesignListDemographyAgeState with _$SurveyDesignListDemographyAgeState {
  const factory SurveyDesignListDemographyAgeState.initial() = _Initial;
  const factory SurveyDesignListDemographyAgeState.loading() = _Loading;
  const factory SurveyDesignListDemographyAgeState.loaded(List<ListDemographyAge> data) = _Loaded;
  const factory SurveyDesignListDemographyAgeState.error(String message) = _Error;
}
