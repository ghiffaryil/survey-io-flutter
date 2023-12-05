part of 'update_passcode_bloc.dart';

@freezed
class UpdatePasscodeEvent with _$UpdatePasscodeEvent {
  const factory UpdatePasscodeEvent.started() = _Started;
  const factory UpdatePasscodeEvent.updatePasscode(String phoneNumber, String pin) = _UpdatePasscode;
}