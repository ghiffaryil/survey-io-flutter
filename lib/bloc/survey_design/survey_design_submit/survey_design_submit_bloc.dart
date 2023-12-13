import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/submit/survey_design_submit_datasource.dart';

part 'survey_design_submit_event.dart';
part 'survey_design_submit_state.dart';
part 'survey_design_submit_bloc.freezed.dart';

class SurveyDesignSubmitBloc
    extends Bloc<SurveyDesignSubmitEvent, SurveyDesignSubmitState> {
  SurveyDesignSubmitBloc() : super(const _Initial()) {
    on<_SubmitSurveyDesign>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyDesignSubmitDatasource()
          .setSurveyDesignSubmit(event.surveyDesignId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
