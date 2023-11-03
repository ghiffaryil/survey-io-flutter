part of 'polling_done_bloc.dart';

@freezed
class PollingDoneState with _$PollingDoneState {
  const factory PollingDoneState.initial() = _Initial;
  const factory PollingDoneState.loading() = _Loading;
  const factory PollingDoneState.loaded(List<PollingDone> listPollingDone) =
      _Loaded;
  const factory PollingDoneState.error(String message) = _Error;
}
