import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/register/verify_otp.dart';
import 'package:survey_io/models/register/verification_otp_response_model.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';
part 'verify_otp_bloc.freezed.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(const _Initial()) {
    on<_VerifyOtp>((event, emit) async {
      emit(const _Loading());
      final response = await VerifyOtpDatasource()
          .verifyOtp(event.phoneNumber, event.otpCode);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
