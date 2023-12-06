import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_marital_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_marital_response_model.dart';

part 'survey_design_list_demography_marital_event.dart';
part 'survey_design_list_demography_marital_state.dart';
part 'survey_design_list_demography_marital_bloc.freezed.dart';

class SurveyDesignListDemographyMaritalBloc extends Bloc<SurveyDesignListDemographyMaritalEvent, SurveyDesignListDemographyMaritalState> {
  SurveyDesignListDemographyMaritalBloc() : super(const _Initial()) {
     on<_GetListDemographyMarital>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyMaritalDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
