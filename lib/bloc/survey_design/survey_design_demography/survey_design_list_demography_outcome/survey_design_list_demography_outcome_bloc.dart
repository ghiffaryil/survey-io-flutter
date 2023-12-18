import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_outcome_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_outcome_response_model.dart';

part 'survey_design_list_demography_outcome_event.dart';
part 'survey_design_list_demography_outcome_state.dart';
part 'survey_design_list_demography_outcome_bloc.freezed.dart';

class SurveyDesignListDemographyOutcomeBloc extends Bloc<
    SurveyDesignListDemographyOutcomeEvent,
    SurveyDesignListDemographyOutcomeState> {
  SurveyDesignListDemographyOutcomeBloc() : super(const _Initial()) {
    on<_GetListDemographyOutcome>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyOutcomeDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
