part of 'request_otp_bloc.dart';

@freezed
class RequestOtpEvent with _$RequestOtpEvent {
  const factory RequestOtpEvent.started() = _Started;
  const factory RequestOtpEvent.requestOtp(String email) = _RequestOtp;
}
