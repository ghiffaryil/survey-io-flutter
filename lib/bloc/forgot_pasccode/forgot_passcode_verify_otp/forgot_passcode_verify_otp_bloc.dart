import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/forgot_passcode/forgot_passcode_verify_otp.dart';

part 'forgot_passcode_verify_otp_event.dart';
part 'forgot_passcode_verify_otp_state.dart';
part 'forgot_passcode_verify_otp_bloc.freezed.dart';

class ForgotPasscodeVerifyOtpBloc
    extends Bloc<ForgotPasscodeVerifyOtpEvent, ForgotPasscodeVerifyOtpState> {
  ForgotPasscodeVerifyOtpBloc() : super(const _Initial()) {
    on<_VerifyOtp>((event, emit) async {
      emit(const _Loading());
      final response = await ForgotPasscodeVerifyOtpDatasource()
          .verifyOtp(event.phoneNumber, event.otpCode);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
