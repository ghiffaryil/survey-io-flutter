part of 'survey_design_is_calculate_bloc.dart';

@freezed
class SurveyDesignIsCalculateEvent with _$SurveyDesignIsCalculateEvent {
  const factory SurveyDesignIsCalculateEvent.started() = _Started;
  const factory SurveyDesignIsCalculateEvent.isCalculate(
      SurveyDesignIsCalculateRequestModel requestModel) = _IsCalculate;
}
