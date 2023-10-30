import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/polling/polling_datasource.dart';

import '../../../models/polling/polling_response_model.dart';

part 'polling_event.dart';
part 'polling_state.dart';
part 'polling_bloc.freezed.dart';

class PollingBloc extends Bloc<PollingEvent, PollingState> {
  PollingBloc() : super(const _Initial()) {
    on<_GetPolling>((event, emit) async {
      emit(const _Loading());
      final response = await PollingDatasource().getPollingList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
