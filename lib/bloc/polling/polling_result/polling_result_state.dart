part of 'polling_result_bloc.dart';

@freezed
class PollingResultState with _$PollingResultState {
  const factory PollingResultState.initial() = _Initial;
  const factory PollingResultState.loading() = _Loading;
  const factory PollingResultState.loaded(
      List<PollingResultList> listPollingResult) = _Loaded;
  const factory PollingResultState.error(String message) = _Error;
}
