import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_gender_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_gender_response_model.dart';

part 'survey_design_list_demography_gender_event.dart';
part 'survey_design_list_demography_gender_state.dart';
part 'survey_design_list_demography_gender_bloc.freezed.dart';

class SurveyDesignListDemographyGenderBloc extends Bloc<SurveyDesignListDemographyGenderEvent, SurveyDesignListDemographyGenderState> {
  SurveyDesignListDemographyGenderBloc() : super(const _Initial()) {
    on<_GetListDemographyGender>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyGenderDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
