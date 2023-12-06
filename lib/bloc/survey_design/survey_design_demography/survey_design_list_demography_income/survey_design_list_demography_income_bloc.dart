import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_income_response_model.dart';

part 'survey_design_list_demography_income_event.dart';
part 'survey_design_list_demography_income_state.dart';
part 'survey_design_list_demography_income_bloc.freezed.dart';

class SurveyDesignListDemographyIncomeBloc extends Bloc<SurveyDesignListDemographyIncomeEvent, SurveyDesignListDemographyIncomeState> {
  SurveyDesignListDemographyIncomeBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
