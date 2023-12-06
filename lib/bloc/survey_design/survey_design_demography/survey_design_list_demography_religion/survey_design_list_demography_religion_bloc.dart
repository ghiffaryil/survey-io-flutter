import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_religion_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_religion_response_model.dart';

part 'survey_design_list_demography_religion_event.dart';
part 'survey_design_list_demography_religion_state.dart';
part 'survey_design_list_demography_religion_bloc.freezed.dart';

class SurveyDesignListDemographyReligionBloc extends Bloc<SurveyDesignListDemographyReligionEvent, SurveyDesignListDemographyReligionState> {
  SurveyDesignListDemographyReligionBloc() : super(const _Initial()) {
     on<_GetListDemographyReligion>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyReligionDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
