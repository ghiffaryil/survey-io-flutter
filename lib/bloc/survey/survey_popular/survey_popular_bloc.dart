import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../datasources/survey/survey_popular_datasource.dart';
import '../../../models/survey/list/survey_list_response_model.dart';

part 'survey_popular_event.dart';
part 'survey_popular_state.dart';
part 'survey_popular_bloc.freezed.dart';

class SurveyPopularBloc extends Bloc<SurveyPopularEvent, SurveyPopularState> {
  SurveyPopularBloc() : super(const _Initial()) {
    on<_GetSurveyPopular>((event, emit) async {
      emit(const _Loading());
      final response =
          await SurveyPopularListDatasource().getSurveyPopularList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
