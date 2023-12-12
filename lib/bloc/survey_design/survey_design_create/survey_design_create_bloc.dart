import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/create/survey_design_create_datasource.dart';
import 'package:survey_io/models/survey_design/create/survey_design_create_request_model.dart';
import 'package:survey_io/models/survey_design/create/survey_design_create_response_model.dart';

part 'survey_design_create_event.dart';
part 'survey_design_create_state.dart';
part 'survey_design_create_bloc.freezed.dart';

class SurveyDesignCreateBloc
    extends Bloc<SurveyDesignCreateEvent, SurveyDesignCreateState> {
  SurveyDesignCreateBloc() : super(const _Initial()) {
    on<_Create>((event, emit) async {
      emit(const _Loading());
      final response =
          await SurveyDesignCreateDatasource().Create(event.requestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
