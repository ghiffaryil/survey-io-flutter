part of 'survey_design_list_demography_religion_bloc.dart';

@freezed
class SurveyDesignListDemographyReligionState with _$SurveyDesignListDemographyReligionState {
  const factory SurveyDesignListDemographyReligionState.initial() = _Initial;
  const factory SurveyDesignListDemographyReligionState.loading() = _Loading;
  const factory SurveyDesignListDemographyReligionState.loaded(List<ListDemographyReligion> data) = _Loaded;
  const factory SurveyDesignListDemographyReligionState.error(String message) = _Error;
}
