import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/is_calculate/survey_design_is_calculate_datasource.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_request_model.dart';
import 'package:survey_io/models/survey_design/is_calculate/survey_design_is_calculate_response_model.dart';

part 'survey_design_is_calculate_event.dart';
part 'survey_design_is_calculate_state.dart';
part 'survey_design_is_calculate_bloc.freezed.dart';

class SurveyDesignIsCalculateBloc
    extends Bloc<SurveyDesignIsCalculateEvent, SurveyDesignIsCalculateState> {
  SurveyDesignIsCalculateBloc() : super(const _Initial()) {
    on<_IsCalculate>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyDesignIsCalculateDatasource()
          .isCalculate(event.requestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
