import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/option/get_respondent_datasource.dart';
import 'package:survey_io/models/survey_design/option/survey_respondent_response_model.dart';

part 'survey_design_list_respondent_event.dart';
part 'survey_design_list_respondent_state.dart';
part 'survey_design_list_respondent_bloc.freezed.dart';

class SurveyDesignListRespondentBloc extends Bloc<
    SurveyDesignListRespondentEvent, SurveyDesignListRespondentState> {
  SurveyDesignListRespondentBloc() : super(const _Initial()) {
    on<_GetSurveyDesignListRespondent>((event, emit) async {
      emit(const _Loading());
      final response = await GetSurveyRespondentDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
