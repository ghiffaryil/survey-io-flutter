import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_region_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_region_response_model.dart';

part 'survey_design_list_demography_region_event.dart';
part 'survey_design_list_demography_region_state.dart';
part 'survey_design_list_demography_region_bloc.freezed.dart';

class SurveyDesignListDemographyRegionBloc extends Bloc<SurveyDesignListDemographyRegionEvent, SurveyDesignListDemographyRegionState> {
  SurveyDesignListDemographyRegionBloc() : super(const _Initial()) {
     on<_GetListDemographyRegion>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyRegionDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
