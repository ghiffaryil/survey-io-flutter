import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/forgot_passcode/forgot_passcode_request_otp.dart';

part 'forgot_passcode_request_otp_event.dart';
part 'forgot_passcode_request_otp_state.dart';
part 'forgot_passcode_request_otp_bloc.freezed.dart';

class ForgotPasscodeRequestOtpBloc
    extends Bloc<ForgotPasscodeRequestOtpEvent, ForgotPasscodeRequestOtpState> {
  ForgotPasscodeRequestOtpBloc() : super(const _Initial()) {
    on<_RequestOtp>((event, emit) async {
      emit(const _Loading());
      final response =
          await ForgotPasscodeRequestOtpDatasource().requestOtp(event.email);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
