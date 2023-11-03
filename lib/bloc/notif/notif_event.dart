part of 'notif_bloc.dart';

@freezed
class NotifEvent with _$NotifEvent {
  const factory NotifEvent.started() = _Started;
  const factory NotifEvent.getNotif() = _GetNotif;
}