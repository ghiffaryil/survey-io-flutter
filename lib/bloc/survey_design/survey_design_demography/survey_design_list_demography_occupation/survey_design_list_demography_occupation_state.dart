part of 'survey_design_list_demography_occupation_bloc.dart';

@freezed
class SurveyDesignListDemographyOccupationState with _$SurveyDesignListDemographyOccupationState {
  const factory SurveyDesignListDemographyOccupationState.initial() = _Initial;
  const factory SurveyDesignListDemographyOccupationState.loading() = _Loading;
  const factory SurveyDesignListDemographyOccupationState.loaded(List<ListDemographyOccupation> data) = _Loaded;
  const factory SurveyDesignListDemographyOccupationState.error(String message) = _Error;
}
