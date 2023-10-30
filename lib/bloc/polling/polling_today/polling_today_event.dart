part of 'polling_today_bloc.dart';

@freezed
class PollingTodayEvent with _$PollingTodayEvent {
  const factory PollingTodayEvent.started() = _Started;
  const factory PollingTodayEvent.getPollingToday() = _GetPollingToday;
}