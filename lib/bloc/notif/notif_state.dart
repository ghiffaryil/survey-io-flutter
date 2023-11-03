part of 'notif_bloc.dart';

@freezed
class NotifState with _$NotifState {
  const factory NotifState.initial() = _Initial;
  const factory NotifState.loading() = _Loading;
  const factory NotifState.loaded(List<NotificationList> notificationList) = _Loaded;
  const factory NotifState.error(String message) = _Error;
}
