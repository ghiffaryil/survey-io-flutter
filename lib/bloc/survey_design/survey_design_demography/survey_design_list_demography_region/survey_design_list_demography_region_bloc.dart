import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_region_response_model.dart';

part 'survey_design_list_demography_region_event.dart';
part 'survey_design_list_demography_region_state.dart';
part 'survey_design_list_demography_region_bloc.freezed.dart';

class SurveyDesignListDemographyRegionBloc extends Bloc<SurveyDesignListDemographyRegionEvent, SurveyDesignListDemographyRegionState> {
  SurveyDesignListDemographyRegionBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyRegionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
