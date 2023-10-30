part of 'polling_bloc.dart';

@freezed
class PollingEvent with _$PollingEvent {
  const factory PollingEvent.started() = _Started;
  const factory PollingEvent.getPolling() = _GetPolling;
}