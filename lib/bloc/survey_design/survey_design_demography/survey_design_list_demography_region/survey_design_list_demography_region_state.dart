part of 'survey_design_list_demography_region_bloc.dart';

@freezed
class SurveyDesignListDemographyRegionState
    with _$SurveyDesignListDemographyRegionState {
  const factory SurveyDesignListDemographyRegionState.initial() = _Initial;
  const factory SurveyDesignListDemographyRegionState.loading() = _Loading;
  const factory SurveyDesignListDemographyRegionState.loaded(
      List<ListDemographyRegion> data) = _Loaded;
  const factory SurveyDesignListDemographyRegionState.error(String error) =
      _Error;
}
