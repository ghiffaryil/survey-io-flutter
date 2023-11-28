part of 'verify_otp_bloc.dart';

@freezed
class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.started() = _Started;
  const factory VerifyOtpEvent.verifyOtp(String phoneNumber, String otpCode) = _VerifyOtp;
}