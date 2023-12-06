import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_religion_response_model.dart';

part 'survey_design_list_demography_religion_event.dart';
part 'survey_design_list_demography_religion_state.dart';
part 'survey_design_list_demography_religion_bloc.freezed.dart';

class SurveyDesignListDemographyReligionBloc extends Bloc<SurveyDesignListDemographyReligionEvent, SurveyDesignListDemographyReligionState> {
  SurveyDesignListDemographyReligionBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyReligionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
