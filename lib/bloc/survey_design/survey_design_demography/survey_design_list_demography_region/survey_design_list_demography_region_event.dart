part of 'survey_design_list_demography_region_bloc.dart';

@freezed
class SurveyDesignListDemographyRegionEvent with _$SurveyDesignListDemographyRegionEvent {
  const factory SurveyDesignListDemographyRegionEvent.started() = _Started;
  const factory SurveyDesignListDemographyRegionEvent.getListDemographyRegion() = _GetListDemographyRegion;
}