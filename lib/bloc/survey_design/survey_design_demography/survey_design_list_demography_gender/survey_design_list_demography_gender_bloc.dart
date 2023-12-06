import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_gender_response_model.dart';

part 'survey_design_list_demography_gender_event.dart';
part 'survey_design_list_demography_gender_state.dart';
part 'survey_design_list_demography_gender_bloc.freezed.dart';

class SurveyDesignListDemographyGenderBloc extends Bloc<SurveyDesignListDemographyGenderEvent, SurveyDesignListDemographyGenderState> {
  SurveyDesignListDemographyGenderBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyGenderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
