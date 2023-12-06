import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_marital_response_model.dart';

part 'survey_design_list_demography_marital_event.dart';
part 'survey_design_list_demography_marital_state.dart';
part 'survey_design_list_demography_marital_bloc.freezed.dart';

class SurveyDesignListDemographyMaritalBloc extends Bloc<SurveyDesignListDemographyMaritalEvent, SurveyDesignListDemographyMaritalState> {
  SurveyDesignListDemographyMaritalBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyMaritalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
