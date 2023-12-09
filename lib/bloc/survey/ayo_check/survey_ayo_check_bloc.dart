import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey/survey_ayocheck_datasource.dart';
import 'package:survey_io/models/survey/ayo_check/survey_ayocheck_response_model.dart';

part 'survey_ayo_check_event.dart';
part 'survey_ayo_check_state.dart';
part 'survey_ayo_check_bloc.freezed.dart';

class SurveyAyoCheckBloc
    extends Bloc<SurveyAyoCheckEvent, SurveyAyoCheckState> {
  SurveyAyoCheckBloc() : super(const _Initial()) {
    on<_GetSurveyAyoCheck>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyAyoCheckDatasource().getSurveyAyoCheck();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
