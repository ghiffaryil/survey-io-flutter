part of 'polling_today_bloc.dart';

@freezed
class PollingTodayState with _$PollingTodayState {
  const factory PollingTodayState.initial() = _Initial;
  const factory PollingTodayState.loading() = _Loading;
  const factory PollingTodayState.loaded(List<PollingTodayData> pollingTodayData) = _Loaded;
  const factory PollingTodayState.error(String message) = _Error;
}
