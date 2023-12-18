part of 'update_passcode_bloc.dart';

@freezed
class UpdatePasscodeState with _$UpdatePasscodeState {
  const factory UpdatePasscodeState.initial() = _Initial;
  const factory UpdatePasscodeState.loading() = _Loading;
  const factory UpdatePasscodeState.loaded(String data) = _Loaded;
  const factory UpdatePasscodeState.error(String message) = _Error;
}
