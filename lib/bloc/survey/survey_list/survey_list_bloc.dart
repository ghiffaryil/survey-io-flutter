import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey/survey_list_datasource.dart';

import '../../../models/survey/list/survey_list_response_model.dart';

part 'survey_list_event.dart';
part 'survey_list_state.dart';
part 'survey_list_bloc.freezed.dart';

class SurveyListBloc extends Bloc<SurveyListEvent, SurveyListState> {
  SurveyListBloc() : super(const _Initial()) {
    on<_GetSurveyList>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyListDatasource().getSurveyList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
