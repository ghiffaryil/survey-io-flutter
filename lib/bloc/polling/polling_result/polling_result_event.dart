part of 'polling_result_bloc.dart';

@freezed
class PollingResultEvent with _$PollingResultEvent {
  const factory PollingResultEvent.started() = _Started;
  const factory PollingResultEvent.getListPollingResult(int pollingId) =
      _GetListPollingResult;
}
