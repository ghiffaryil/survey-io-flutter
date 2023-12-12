part of 'survey_design_create_bloc.dart';

@freezed
class SurveyDesignCreateEvent with _$SurveyDesignCreateEvent {
  const factory SurveyDesignCreateEvent.started() = _Started;
  const factory SurveyDesignCreateEvent.create(SurveyDesignCreateRequestModel requestModel) = _Create;
}