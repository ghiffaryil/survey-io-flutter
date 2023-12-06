part of 'survey_design_list_demography_outcome_bloc.dart';

@freezed
class SurveyDesignListDemographyOutcomeEvent with _$SurveyDesignListDemographyOutcomeEvent {
  const factory SurveyDesignListDemographyOutcomeEvent.started() = _Started;
  const factory SurveyDesignListDemographyOutcomeEvent.getDemographyOutcome() = _GetDemographyOutcome;
}