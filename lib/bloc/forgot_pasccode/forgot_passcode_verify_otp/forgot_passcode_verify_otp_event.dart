part of 'forgot_passcode_verify_otp_bloc.dart';

@freezed
class ForgotPasscodeVerifyOtpEvent with _$ForgotPasscodeVerifyOtpEvent {
  const factory ForgotPasscodeVerifyOtpEvent.started() = _Started;
  const factory ForgotPasscodeVerifyOtpEvent.verifyOtp(
      String email, String otpCode) = _VerifyOtp;
}
