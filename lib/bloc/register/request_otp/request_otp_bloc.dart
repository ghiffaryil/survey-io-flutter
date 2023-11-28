import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_io/datasources/register/request_otp.dart';

part 'request_otp_event.dart';
part 'request_otp_state.dart';
part 'request_otp_bloc.freezed.dart';

class RequestOtpBloc extends Bloc<RequestOtpEvent, RequestOtpState> {
  RequestOtpBloc() : super(const _Initial()) {
    on<_RequestOtp>((event, emit) async {
      emit(const _Loading());
      final response = await RequestOtpDatasource().requestOtp(event.phoneNumber);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
