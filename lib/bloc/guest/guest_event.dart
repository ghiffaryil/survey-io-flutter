part of 'guest_bloc.dart';

@freezed
class GuestEvent with _$GuestEvent {
  const factory GuestEvent.started() = _Started;
  const factory GuestEvent.getGuestToken() = _GetGuestToken;
}
