part of 'polling_participate_bloc.dart';

@freezed
class PollingParticipateEvent with _$PollingParticipateEvent {
  const factory PollingParticipateEvent.started() = _Started;
  const factory PollingParticipateEvent.setPollingParticipate(int pollingListId) = _SetPollingParticipate;
}