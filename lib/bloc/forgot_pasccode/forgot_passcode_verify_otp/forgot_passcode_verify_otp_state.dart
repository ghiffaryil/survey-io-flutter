part of 'forgot_passcode_verify_otp_bloc.dart';

@freezed
class ForgotPasscodeVerifyOtpState with _$ForgotPasscodeVerifyOtpState {
  const factory ForgotPasscodeVerifyOtpState.initial() = _Initial;
  const factory ForgotPasscodeVerifyOtpState.loading() = _Loading;
  const factory ForgotPasscodeVerifyOtpState.loaded(String data) = _Loaded;
  const factory ForgotPasscodeVerifyOtpState.error(String message) = _Error;
}
