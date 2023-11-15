part of 'reedem_history_bloc.dart';

@freezed
class ReedemHistoryState with _$ReedemHistoryState {
  const factory ReedemHistoryState.initial() = _Initial;
  const factory ReedemHistoryState.loading() = _Loading;
  const factory ReedemHistoryState.loaded(List<ReedemHistoryList> data) = _Loaded;
  const factory ReedemHistoryState.error(String message) = _Error;
}
