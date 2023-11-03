part of 'polling_done_bloc.dart';

@freezed
class PollingDoneEvent with _$PollingDoneEvent {
  const factory PollingDoneEvent.started() = _Started;
  const factory PollingDoneEvent.getPollingDone() = _GetPollingDone;
}