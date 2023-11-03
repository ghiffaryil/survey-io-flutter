import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/polling/polling_today_datasource.dart';

import '../../../models/polling/polling_today_response_model.dart';

part 'polling_today_event.dart';
part 'polling_today_state.dart';
part 'polling_today_bloc.freezed.dart';

class PollingTodayBloc extends Bloc<PollingTodayEvent, PollingTodayState> {
  PollingTodayBloc() : super(const _Initial()) {
    on<_GetPollingToday>((event, emit) async {
      emit(const _Loading());
      final response = await PollingTodayDatasource().getPollingTodayList();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
