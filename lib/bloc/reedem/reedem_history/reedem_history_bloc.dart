import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/reedem/reedem_history_datasource.dart';
import 'package:survey_io/models/reedem/reedem_history_response_model.dart';

part 'reedem_history_event.dart';
part 'reedem_history_state.dart';
part 'reedem_history_bloc.freezed.dart';

class ReedemHistoryBloc extends Bloc<ReedemHistoryEvent, ReedemHistoryState> {
  ReedemHistoryBloc() : super(const _Initial()) {
    on<_GetListReedemHistory>((event, emit) async {
      emit(const _Loading());
      final response =
          await ReedemHistoryDatasource().getListReedemHistory();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
