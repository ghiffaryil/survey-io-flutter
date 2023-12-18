import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_age_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_age_response_model.dart';

part 'survey_design_list_demography_age_event.dart';
part 'survey_design_list_demography_age_state.dart';
part 'survey_design_list_demography_age_bloc.freezed.dart';

class SurveyDesignListDemographyAgeBloc extends Bloc<
    SurveyDesignListDemographyAgeEvent, SurveyDesignListDemographyAgeState> {
  SurveyDesignListDemographyAgeBloc() : super(const _Initial()) {
    on<_GetListDemographyAge>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyAgeDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
