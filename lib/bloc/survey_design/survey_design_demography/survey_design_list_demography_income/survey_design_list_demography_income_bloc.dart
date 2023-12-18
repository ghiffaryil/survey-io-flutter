import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_income_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_income_response_model.dart';

part 'survey_design_list_demography_income_event.dart';
part 'survey_design_list_demography_income_state.dart';
part 'survey_design_list_demography_income_bloc.freezed.dart';

class SurveyDesignListDemographyIncomeBloc extends Bloc<
    SurveyDesignListDemographyIncomeEvent,
    SurveyDesignListDemographyIncomeState> {
  SurveyDesignListDemographyIncomeBloc() : super(const _Initial()) {
    on<_GetListDemographyIncome>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyIncomeDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
