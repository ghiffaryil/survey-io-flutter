part of 'survey_design_list_report_time_bloc.dart';

@freezed
class SurveyDesignListReportTimeEvent with _$SurveyDesignListReportTimeEvent {
  const factory SurveyDesignListReportTimeEvent.started() = _Started;
  const factory SurveyDesignListReportTimeEvent.getSurveyDesignListReportTime() = _GetSurveyDesignListReportTime;
}