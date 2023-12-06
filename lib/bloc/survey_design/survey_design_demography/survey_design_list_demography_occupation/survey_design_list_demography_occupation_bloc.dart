import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_occupation_response_model.dart';

part 'survey_design_list_demography_occupation_event.dart';
part 'survey_design_list_demography_occupation_state.dart';
part 'survey_design_list_demography_occupation_bloc.freezed.dart';

class SurveyDesignListDemographyOccupationBloc extends Bloc<SurveyDesignListDemographyOccupationEvent, SurveyDesignListDemographyOccupationState> {
  SurveyDesignListDemographyOccupationBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyOccupationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
