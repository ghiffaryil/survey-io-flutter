import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/polling/polling_done_datasource.dart';

import '../../../models/polling/polling_done_response_model.dart';

part 'polling_done_event.dart';
part 'polling_done_state.dart';
part 'polling_done_bloc.freezed.dart';

class PollingDoneBloc extends Bloc<PollingDoneEvent, PollingDoneState> {
  PollingDoneBloc() : super(const _Initial()) {
    on<_GetPollingDone>((event, emit) async {
      emit(const _Loading());
      final response = await PollingDoneDatasource().getPollingDoneList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
