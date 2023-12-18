part of 'survey_design_is_create_bloc.dart';

@freezed
class SurveyDesignIsCreateEvent with _$SurveyDesignIsCreateEvent {
  const factory SurveyDesignIsCreateEvent.started() = _Started;
  const factory SurveyDesignIsCreateEvent.isCreate(SurveyDesignIsCreateRequestModel requestModel) = _IsCreate;
}