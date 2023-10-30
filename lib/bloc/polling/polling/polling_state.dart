part of 'polling_bloc.dart';

@freezed
class PollingState with _$PollingState {
  const factory PollingState.initial() = _Initial;
  const factory PollingState.loading() = _Loading;
  const factory PollingState.loaded(List<PollingData> pollingList) = _Loaded;
  const factory PollingState.error(String message) = _Error;
}
