import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/demography/get_demography_children_datasource.dart';
import 'package:survey_io/models/survey_design/demography/demography_children_response_model.dart';

part 'survey_design_list_demography_children_event.dart';
part 'survey_design_list_demography_children_state.dart';
part 'survey_design_list_demography_children_bloc.freezed.dart';

class SurveyDesignListDemographyChildrenBloc extends Bloc<SurveyDesignListDemographyChildrenEvent, SurveyDesignListDemographyChildrenState> {
  SurveyDesignListDemographyChildrenBloc() : super(const _Initial()) {
    on<_GetListDemographyChildren>((event, emit) async {
      emit(const _Loading());
      final response = await GetDemographyChildrenDatasource().getData();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
