import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_occupation_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_occupation_response_model.dart';

part 'survey_design_list_demography_occupation_event.dart';
part 'survey_design_list_demography_occupation_state.dart';
part 'survey_design_list_demography_occupation_bloc.freezed.dart';

class SurveyDesignListDemographyOccupationBloc extends Bloc<SurveyDesignListDemographyOccupationEvent, SurveyDesignListDemographyOccupationState> {
  SurveyDesignListDemographyOccupationBloc() : super(const _Initial()) {
    on<_GetListDemographyOccupation>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyOccupationDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
