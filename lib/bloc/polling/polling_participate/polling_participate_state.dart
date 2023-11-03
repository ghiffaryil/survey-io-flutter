part of 'polling_participate_bloc.dart';

@freezed
class PollingParticipateState with _$PollingParticipateState {
  const factory PollingParticipateState.initial() = _Initial;
  const factory PollingParticipateState.loading() = _Loading;
  const factory PollingParticipateState.loaded(String message) = _Loaded;
  const factory PollingParticipateState.error(String message) = _Error;
  
}
