import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/list/survey_design_list_datasource.dart';
import 'package:survey_io/models/survey_design/list/survey_design_list_response_model.dart';

part 'survey_design_list_event.dart';
part 'survey_design_list_state.dart';
part 'survey_design_list_bloc.freezed.dart';

class SurveyDesignListBloc
    extends Bloc<SurveyDesignListEvent, SurveyDesignListState> {
  SurveyDesignListBloc() : super(const _Initial()) {
    on<_GetSurveyDesignList>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyDesignListDatasource().getSurveyDesignList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
