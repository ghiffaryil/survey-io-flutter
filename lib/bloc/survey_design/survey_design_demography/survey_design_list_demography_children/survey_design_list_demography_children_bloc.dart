import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/models/survey_design/demography/demography_children_response_model.dart';

part 'survey_design_list_demography_children_event.dart';
part 'survey_design_list_demography_children_state.dart';
part 'survey_design_list_demography_children_bloc.freezed.dart';

class SurveyDesignListDemographyChildrenBloc extends Bloc<SurveyDesignListDemographyChildrenEvent, SurveyDesignListDemographyChildrenState> {
  SurveyDesignListDemographyChildrenBloc() : super(_Initial()) {
    on<SurveyDesignListDemographyChildrenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
