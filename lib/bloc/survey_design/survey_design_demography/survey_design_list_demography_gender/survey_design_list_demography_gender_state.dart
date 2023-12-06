part of 'survey_design_list_demography_gender_bloc.dart';

@freezed
class SurveyDesignListDemographyGenderState with _$SurveyDesignListDemographyGenderState {
  const factory SurveyDesignListDemographyGenderState.initial() = _Initial;
  const factory SurveyDesignListDemographyGenderState.loading() = _Loading;
  const factory SurveyDesignListDemographyGenderState.loaded(List<ListDemographyGender> data) = _Loaded;
  const factory SurveyDesignListDemographyGenderState.error(String message) = _Error;
}
