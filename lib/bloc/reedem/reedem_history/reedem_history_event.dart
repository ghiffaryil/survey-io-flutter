part of 'reedem_history_bloc.dart';

@freezed
class ReedemHistoryEvent with _$ReedemHistoryEvent {
  const factory ReedemHistoryEvent.started() = _Started;
  const factory ReedemHistoryEvent.getListReedemHistory() = _GetListReedemHistory;
}