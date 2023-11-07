import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/polling/polling_result_datasource.dart';

import '../../../models/polling/polling_result_response_model.dart';

part 'polling_result_event.dart';
part 'polling_result_state.dart';
part 'polling_result_bloc.freezed.dart';

class PollingResultBloc extends Bloc<PollingResultEvent, PollingResultState> {
  PollingResultBloc() : super(const _Initial()) {
    on<_GetListPollingResult>((event, emit) async {
      emit(const _Loading());
      final response =
          await PollingResultDatasource().getPollingResultList(event.pollingId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
