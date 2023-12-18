import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/survey_design/is_create/survey_design_is_create_datasource.dart';
import 'package:survey_io/models/survey_design/is_create/survey_design_is_create_request_model.dart';

part 'survey_design_is_create_event.dart';
part 'survey_design_is_create_state.dart';
part 'survey_design_is_create_bloc.freezed.dart';

class SurveyDesignIsCreateBloc extends Bloc<SurveyDesignIsCreateEvent, SurveyDesignIsCreateState> {
  SurveyDesignIsCreateBloc() : super(const _Initial()) {
    on<_IsCreate>((event, emit) async {
      emit(const _Loading());
      final response = await SurveyDesignIsCreateDatasource()
          .isCreate(event.requestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
