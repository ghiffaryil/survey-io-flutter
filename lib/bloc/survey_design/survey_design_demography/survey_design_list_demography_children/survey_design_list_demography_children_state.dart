part of 'survey_design_list_demography_children_bloc.dart';

@freezed
class SurveyDesignListDemographyChildrenState with _$SurveyDesignListDemographyChildrenState {
  const factory SurveyDesignListDemographyChildrenState.initial() = _Initial;
  const factory SurveyDesignListDemographyChildrenState.loading() = _Loading;
  const factory SurveyDesignListDemographyChildrenState.loaded(List<ListDemographyChildren> data) = _Loaded;
  const factory SurveyDesignListDemographyChildrenState.error(String message) = _Error;
}
