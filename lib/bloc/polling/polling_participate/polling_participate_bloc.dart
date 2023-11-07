import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../datasources/polling/polling_participate_datasource.dart';

part 'polling_participate_event.dart';
part 'polling_participate_state.dart';
part 'polling_participate_bloc.freezed.dart';

class PollingParticipateBloc
    extends Bloc<PollingParticipateEvent, PollingParticipateState> {
  PollingParticipateBloc() : super(const _Initial()) {
    on<_SetPollingParticipate>((event, emit) async {
      emit(const _Loading());
      final response =
          await PollingParticipateDatasource().setPollingParticipate(event.pollingListId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
