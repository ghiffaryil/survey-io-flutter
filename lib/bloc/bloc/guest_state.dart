part of 'guest_bloc.dart';

@freezed
class GuestState with _$GuestState {
  const factory GuestState.initial() = _Initial;
  const factory GuestState.loading() = _Loading;
  const factory GuestState.loaded(AuthGuestResponseModel data) = _Loaded;
  const factory GuestState.error(String message) = _Error;
}
