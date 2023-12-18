import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/option/get_report_time_datasource.dart';
import 'package:survey_io/models/survey_design/option/survey_report_time_response_model.dart';

part 'survey_design_list_report_time_event.dart';
part 'survey_design_list_report_time_state.dart';
part 'survey_design_list_report_time_bloc.freezed.dart';

class SurveyDesignListReportTimeBloc extends Bloc<
    SurveyDesignListReportTimeEvent, SurveyDesignListReportTimeState> {
  SurveyDesignListReportTimeBloc() : super(const _Initial()) {
    on<_GetSurveyDesignListReportTime>((event, emit) async {
      emit(const _Loading());
      final response = await GetSurveyReportTimeDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
