part of 'forgot_passcode_request_otp_bloc.dart';

@freezed
class ForgotPasscodeRequestOtpEvent with _$ForgotPasscodeRequestOtpEvent {
  const factory ForgotPasscodeRequestOtpEvent.started() = _Started;
  const factory ForgotPasscodeRequestOtpEvent.requestOtp(String phoneNumber) =
      _RequestOtp;
}
