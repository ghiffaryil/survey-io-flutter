part of 'survey_design_list_report_time_bloc.dart';

@freezed
class SurveyDesignListReportTimeState with _$SurveyDesignListReportTimeState {
  const factory SurveyDesignListReportTimeState.initial() = _Initial;
  const factory SurveyDesignListReportTimeState.loading() = _Loading;
  const factory SurveyDesignListReportTimeState.loaded(List<ListDataReportTime> data) = _Loaded;
  const factory SurveyDesignListReportTimeState.error(String message) = _Error;
}
