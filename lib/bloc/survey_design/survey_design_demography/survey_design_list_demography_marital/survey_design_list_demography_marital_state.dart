part of 'survey_design_list_demography_marital_bloc.dart';

@freezed
class SurveyDesignListDemographyMaritalState with _$SurveyDesignListDemographyMaritalState {
  const factory SurveyDesignListDemographyMaritalState.initial() = _Initial;
  const factory SurveyDesignListDemographyMaritalState.loading() = _Loading;
  const factory SurveyDesignListDemographyMaritalState.loaded(List<ListDemographyMarital> data) = _Loaded;
  const factory SurveyDesignListDemographyMaritalState.error(String message) = _Error;
}
