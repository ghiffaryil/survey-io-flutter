import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_occupation_response_model.dart';

part 'survey_design_list_demography_outcome_event.dart';
part 'survey_design_list_demography_outcome_state.dart';
part 'survey_design_list_demography_outcome_bloc.freezed.dart';

class SurveyDesignListDemographyOutcomeBloc extends Bloc<SurveyDesignListDemographyOutcomeEvent, SurveyDesignListDemographyOutcomeState> {
  SurveyDesignListDemographyOutcomeBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyOutcomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
