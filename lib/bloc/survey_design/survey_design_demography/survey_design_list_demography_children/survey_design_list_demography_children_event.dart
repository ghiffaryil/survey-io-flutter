part of 'survey_design_list_demography_children_bloc.dart';

@freezed
class SurveyDesignListDemographyChildrenEvent with _$SurveyDesignListDemographyChildrenEvent {
  const factory SurveyDesignListDemographyChildrenEvent.started() = _Started;
  const factory SurveyDesignListDemographyChildrenEvent.getListDemographyChildren() = _GetListDemographyChildren;
}