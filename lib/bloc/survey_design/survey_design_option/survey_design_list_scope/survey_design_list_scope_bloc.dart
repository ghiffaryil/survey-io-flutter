import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/option/get_scope_datasource.dart';
import 'package:survey_io/models/survey_design/option/survey_scope_response_model.dart';

part 'survey_design_list_scope_event.dart';
part 'survey_design_list_scope_state.dart';
part 'survey_design_list_scope_bloc.freezed.dart';

class SurveyDesignListScopeBloc
    extends Bloc<SurveyDesignListScopeEvent, SurveyDesignListScopeState> {
  SurveyDesignListScopeBloc() : super(const _Initial()) {
    on<_GetSurveyDesignListScope>((event, emit) async {
      emit(const _Loading());
      final response = await GetSurveyScopeDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
