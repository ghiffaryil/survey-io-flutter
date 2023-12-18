part of 'forgot_passcode_request_otp_bloc.dart';

@freezed
class ForgotPasscodeRequestOtpState with _$ForgotPasscodeRequestOtpState {
  const factory ForgotPasscodeRequestOtpState.initial() = _Initial;
  const factory ForgotPasscodeRequestOtpState.loading() = _Loading;
  const factory ForgotPasscodeRequestOtpState.loaded(String data) = _Loaded;
  const factory ForgotPasscodeRequestOtpState.error(String message) = _Error;
}
